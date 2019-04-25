#In case the container host is a virtual machine hosted on Hyper-V the following 2 commands must be run on the host
Stop-VM CHOST02
Set-VMProcessor -VMName CHOST02 -ExposeVirtualizationExtensions $true
Get-VMNetworkAdapter -VMName CHOST02 | Set-VMNetworkAdapter -MacAddressSpoofing On
Start-VM CHOST02

#Hyper-V must be installed on the container host
Install-WindowsFeature -Name Hyper-V -Restart