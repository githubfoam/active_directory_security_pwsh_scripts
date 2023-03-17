#ChatGPT
#checks for abandoned user accounts in Active Directory and disables them if they meet the criteria

# Set the parameters for the script
$daysInactive = 90  # Number of days without activity before account is considered abandoned
$disabledOU = "OU=Disabled Users,DC=yourdomain,DC=com"  # OU where disabled accounts will be moved

# Get the current date and calculate the date $daysInactive days ago
$currentDate = Get-Date
$inactiveDate = $currentDate.AddDays(-$daysInactive)

# Get a list of all user accounts in Active Directory
$users = Get-ADUser -Filter * -Properties LastLogonTimestamp,Enabled | Where-Object {$_.Enabled -eq $true}

# Loop through each user and check if they have been inactive for $daysInactive days
foreach ($user in $users) {
    if (($user.LastLogonTimestamp -lt $inactiveDate) -or ($user.LastLogonTimestamp -eq $null)) {
        # If the user has been inactive for $daysInactive days or has never logged in, disable the account
        Disable-ADAccount -Identity $user
        Write-Output "Disabled $($user.Name) due to inactivity."
        
        # Move the disabled account to the specified OU
        Move-ADObject -Identity $user.DistinguishedName -TargetPath $disabledOU
        Write-Output "Moved $($user.Name) to $disabledOU."
    }
}

