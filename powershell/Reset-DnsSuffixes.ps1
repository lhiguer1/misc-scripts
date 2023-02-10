$ErrorActionPreference = "Stop"
Set-DnsClientGlobalSetting -SuffixSearchList @()

Write-Host -ForegroundColor Green "DNS suffix list has been cleared."
