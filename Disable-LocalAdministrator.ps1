$ErrorActionPreference = "Stop"
$localAdmin = Get-LocalUser -Name "Administrator"
Disable-LocalUser -InputObject $localAdmin -Debug

Write-Host -ForegroundColor Green "Administrator Disabled."
