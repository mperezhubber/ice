# Zoho Assist unattended install - curl edition
$exe = "$env:TEMP\ZA_Access.exe"
$iss = "$env:TEMP\ZohoAssistAgent.iss"

if (Test-Path 'HKLM:\SOFTWARE\Zoho Assist\Unattended Remote Support') { exit }

curl.exe -sS -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -o $exe "https://github.com/mperezhubber/ice/releases/download/v1/ZA_Access.exe"
curl.exe -sS -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -o $iss "https://raw.githubusercontent.com/mperezhubber/ice/refs/heads/main/ZohoAssistAgent.iss"

Start-Process -FilePath $exe -ArgumentList '-qn -s -f1".\ZohoAssistAgent.iss"' -WorkingDirectory $env:TEMP -Wait
