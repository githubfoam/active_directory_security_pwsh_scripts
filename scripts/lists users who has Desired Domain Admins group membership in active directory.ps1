#ChatGPT
#Generate a powershell script that lists users who has Desired Domain Admins group membership in active directory 
#Desired Domain Admins group membership refers to the specific set of users or groups who should be members of the Domain Admins group.

# Import the ActiveDirectory module
Import-Module ActiveDirectory

# Get the members of the Domain Admins group
$DomainAdmins = Get-ADGroupMember -Identity "Domain Admins"

# Filter out non-user objects
$DomainAdminsUsers = $DomainAdmins | Where-Object { $_.objectClass -eq 'user' }

# Loop through each user and output their Domain Admin status and account disable status
foreach ($User in $DomainAdminsUsers) {
    $Disabled = (Get-ADUser $User.SamAccountName).Enabled -eq $false
    $Status = "user $($User.SamAccountName) is domain administrator, user $($User.SamAccountName) account is "
    if ($Disabled) {
        $Status += "disabled"
    } else {
        $Status += "enabled"
    }
    Write-Host $Status
}
