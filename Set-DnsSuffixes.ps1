<#
.SYNOPSIS
    Set DNS suffixes
.EXAMPLE
    Set-DnsSuffixes
    Set DNS suffixes to default values.

.EXAMPLE
    Set-DnsSuffixes -Suffixes webzone.com, coolfiles.com
    Set DNS suffixes to specified values.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)] # Make Mandatory to force user to manually enter suffixes
    [ValidateSet("domain01.com", "domain02.com")]
    [String[]]
    $Suffixes
)

$ErrorActionPreference = "Stop"
Set-DnsClientGlobalSetting -SuffixSearchList $Suffixes
Write-Host -ForegroundColor Green "DNS suffixes added: $Suffixes"
