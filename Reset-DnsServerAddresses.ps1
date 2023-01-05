$ErrorActionPreference = "Stop"
[System.Array]$netAdapters = Get-NetAdapter -Physical
$netAdapters | Set-DnsClientServerAddress -ResetServerAddresses
Write-Host -ForegroundColor Green "DNS server address list has been cleared."
