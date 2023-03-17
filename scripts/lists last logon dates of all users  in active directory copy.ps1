#ChatGPT
#generate a powershell script that lists last logon dates of all users  in active directory 

# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Get all user accounts and their last logon date
$Users = Get-ADUser -Filter * -Properties LastLogonDate

# Loop through each user and display their last logon date
foreach ($User in $Users) {
    if ($User.LastLogonDate) {
        Write-Host "$($User.SamAccountName) last logged on at $($User.LastLogonDate)"
    } else {
        Write-Host "$($User.SamAccountName) has never logged on."
    }
}
