[CmdletBinding()]
param (
    [Parameter()] # Make Mandatory to force user to manually enter password
    [int]
    $OlderThan = 12
)

$dateCutoff = $(Get-Date).AddMonths(-$OlderThan)
$regex = '^C:\\Users\\user\d{1,100}$'

$profiles = Get-CimInstance -ClassName win32_userprofile | Where-Object { (!$_.Special -and $_.Loaded -EQ $false ) }
$cageTechProfiles = $profiles.Where({ $_.LocalPath -Match $regex })


# folder was deleted without registry deleted
$profilesWithoutFolder = $cageTechProfiles.Where({ !(Test-Path -Path $_.LocalPath) })
$profilesWithFolder = $cageTechProfiles.Where({ Test-Path -Path $_.LocalPath })

# remove profiles whoms folders were deleted
foreach ($profile in $profilesWithoutFolder) {
    Write-Output ('Deleting {0}' -f $profile.LocalPath)
    $profile | Remove-CimInstance -Verbose
}

# folder still exists and older thatn 6 months
foreach ($profile in $profilesWithFolder) {
    $lastWriteTime = (Get-ChildItem C:\Users\ | Where-Object Name -EQ $profile.LocalPath.Split('\')[-1]).LastWriteTime
    if ($lastWriteTime -LT $dateCutoff) {
        Write-Output ('{0} is older than {1}: {2}' -f $profile.LocalPath, $dateCutoff.Date, $lastWriteTime)
        $profile | Remove-CimInstance -Verbose
    }
}
