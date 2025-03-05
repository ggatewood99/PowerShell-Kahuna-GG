Import-Module ActiveDirectory

$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"

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