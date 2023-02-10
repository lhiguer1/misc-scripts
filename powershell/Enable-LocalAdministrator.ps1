<#
.SYNOPSIS
    Enable local Administrator account.
.DESCRIPTION
    Enable local Administrator account. Default password can be changed via commandline arguments.
.EXAMPLE
    Enable-LocalAdministrator
    Enable Administrator account with default password.

.EXAMPLE
    Enable-LocalAdministrator -DefaultPassword "hunter2"
    Enable Administrator account with specified password.
#>


[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)] # Make Mandatory to force user to manually enter password
    [String]
    $DefaultPassword="SUPER_SECRET_SECURE_PASSWORD"
)

$ErrorActionPreference = "Stop"

$localAdmin = Get-LocalUser -Name "Administrator"
# $password = Read-Host "Enter Administrator password" -AsSecureString
$password =  ConvertTo-SecureString -String $DefaultPassword -AsPlainText -Force

Enable-LocalUser -InputObject $localAdmin

Set-LocalUser `
    -InputObject $localAdmin `
    -PasswordNeverExpires:$false `
    -Password $password `
    -UserMayChangePassword:$true

Write-Host -ForegroundColor Green "Administrator Enabled and new password set."
