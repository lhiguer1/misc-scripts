<#
.SYNOPSIS
    Set DNS settings for specified site.
#>


[CmdletBinding(DefaultParameterSetName = "SetIpSettings")]
param (
    [Parameter(Mandatory = $true, ParameterSetName = "SetIpSettings", HelpMessage = "site01, site02")]
    [ValidateSet("site01", "site02")]
    [String[]]
    $Sites,

    [Parameter(Mandatory = $true, ParameterSetName = "SetIpSettings", HelpMessage = "domain01.com, domain02.com")]
    [ValidateSet("domain01.com", "domain02.com")]
    [String[]]
    $Domains
)

$ErrorActionPreference = "Stop"

$header = "site", "domain", "ipaddress"
$csv = "
    site01, domain02.com, 8.8.8.8
    site02, domain01.com, 8.8.4.4
"

[System.Array]$DnsServerAddresses = ConvertFrom-Csv -Header $header $csv | Where-Object { $_.site -in $Sites -and $_.domain -in $Domains }
[System.Array]$netAdapters = Get-NetAdapter -Physical

# first reset
$netAdapters | Set-DnsClientServerAddress -ResetServerAddresses
# set new addresses
$netAdapters | Set-DnsClientServerAddress -ServerAddresses $DnsServerAddresses.ipaddress

Write-Host -ForegroundColor Green "DNS server address updated with the following:"
$DnsServerAddresses | Format-Table
