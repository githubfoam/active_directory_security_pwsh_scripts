#ChatGPT
#Generate a powershell script that lists abandoned user accounts in active directory  


# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Get all user accounts
$Users = Get-ADUser -Filter *

# Get all user accounts and their last logon date
$Users = Get-ADUser -Filter * -Properties LastLogonDate

# Set the number of days since last logon to consider an account as abandoned
$DaysSinceLastLogon = 90

# Loop through each user and check if they are abandoned
foreach ($User in $Users) {
    $LastLogon = $User.LastLogonDate
    if ($LastLogon -ne $null) {
        $DaysSinceLastLogon = (New-TimeSpan -Start $LastLogon).Days
    }
    if ($User.Enabled -and $DaysSinceLastLogon -gt $DaysSinceLastLogon) {
        Write-Host "Abandoned account: $($User.SamAccountName)"
    }
}
