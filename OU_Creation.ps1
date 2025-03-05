Import-Module ActiveDirectory

$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"
$GroupName = "York Users"


# Check if the OU already exists
$existingOU = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OUPath'" -SearchBase $DomainDN

if ($existingOU) {
    Write-Host "OU already exists"
} else {
    New-ADOrganizationalUnit -Name $OUName -Path $DomainDN
    Write-Host "OU created"
}


# List all OUs in the domain
Get-ADOrganizationalUnit -Filter * -SearchBase $DomainDN | Select-Object Name, DistinguishedName

# Check if the OU already exists
$existinggroup = Get-Adgroup -Filter "Name -eq '$GroupName'" -SearchBase $OUPath -ErrorAction SilentlyContinue

if ($existinggroup) {
    Write-Output "group already exists"
} else {
    New-ADGroup -Name $GroupName -GroupScope Global -GroupCategory Security -path $OUPath
    Write-Output "Group created"
}


$LondonUsers = Get-ADUser -Filter {city -eq "London"} -Properties City
foreach ($user in $LondonUsers) {
    # Move user to the London OU
    Move-ADObject -Identity $user -TargetPath $OUPath
    Write-Output "User moved to OU"

    # Adding user to the London Group
    Add-ADGroupMember -Identity $GroupName -Members $user
    Write-Output "User added to group"
}

Get-ADUser -Filter {city -eq "London"} -Properties City | Select-Object Name, City | format-table