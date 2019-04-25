###Run this on a domain ontroller with at least Windows Server 2012 installed
Add-KdsRootKey -EffectiveTime (Get-Date).AddHours(-10) #For test environments only
Add-KdsRootKey -EffectiveImmediately #For production environments

#Create a group for hosts allowed to use the gMSA
New-ADGroup -Name "gMSAHosts" -SamAccountName "gMSAHosts" -GroupScope DomainLocal

#Create the gMSA
New-ADServiceAccount -Name "gMSACont" -DnsHostName "gMSACont.adicorp.com" -ServicePrincipalNames "host/gMSACont", "host/gMSACont.adicorp.com" -PrincipalsAllowedToRetrieveManagedPassword "gMSAHosts"

#Add the container host to the access group
Add-ADGroupMember -Identity "gMSAHosts" -Members "CN=CHOST02,CN=Computers,DC=adicorp,DC=com"


###Run on the container host
#Install the Active Directory Powershell module
Install-WindowsFeature RSAT-AD-PowerShell

#Test that the host can use the gMSA
Test-ADServiceAccount gMSACont

#Install the CredentialSpec module
Install-Module CredentialSpec

#Create a new credentialspec file for the gMSA
New-CredentialSpec -AccountName gMSACont

#Run container as gMSA
docker run --security-opt "credentialspec=file://adicorp_gMSACont.json" -it --user "NT AUTHORITY\NETWORK SERVICE" mcr.microsoft.com/windows/servercore:ltsc2019 powershell

#Verify the gMSA
dir \\adicorp.com\sysvol