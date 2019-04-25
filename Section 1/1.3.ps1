#Get the Docker provide module
Install-Module DockerMsftProvider -Force
#Install the Docker package
Install-Package Docker -ProviderName DockerMsftProvider -Force

#After the install a restart is needed
Restart-Computer

#Check that the Docker servive is running
Get-Service Docker
#Start it in case it is not running
Start-Service Docker

#Test Docker engine
docker version