import-module activedirectory

$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"

foreach ($OU in Get-ADOrganizationalUnit -Filter * -SearchBase "DC=Adatum,DC=com")
{
    if ($OU.DistinguishedName -eq "OU=$OUName,$DomainDN")
    {
        Write-Host "OU already exists"
    }
    else
    {
        New-ADOrganizationalUnit -name $OUName -path $OUPath
        Write-Host "OU created"
    }
}
Get-ADOrganizationalUnit -Filter * -SearchBase "DC=Adatum,DC=com" | Select-Object Name, DistinguishedName