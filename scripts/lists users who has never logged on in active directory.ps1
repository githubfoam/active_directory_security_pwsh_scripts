#ChatGPT
#generate a powershell script that lists users who has never logged on in active directory 

# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Get all user accounts and their last logon date
$Users = Get-ADUser -Filter * -Properties LastLogonDate

# Loop through each user and check if they have never logged on
foreach ($User in $Users) {
    if (!$User.LastLogonDate) {
        Write-Host "$($User.SamAccountName) has never logged on."
    }
}
