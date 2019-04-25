#Run a nanoserver image with Hyper-V isolation
docker run -it --isolation=hyperv mcr.microsoft.com/windows/nanoserver:1809

#Run the ping command with -t
ping localhost -t

#To exit the container use the combination
ctrl+p+q

#Spin up the same container with process isolation
docker run -d mcr.microsoft.com/windows/nanoserver:1809 ping localhost -t

#Install the Hyper-V Powershell module
Install-windowsfeature Hyper-V-PowerShell

#Check if the hyper-v container is seen as a virtual machine
Get-VM

#Obtain the process id of ping running in the windows server container and hyper-v container
docker top <containerid>

#Get all ping processes on the container host
Get-Process -Name ping

#Get all hyper-v worker processes on the host
Get-Process -Name vmwp

#Stop the 2 containers
docker stop <containerid>



