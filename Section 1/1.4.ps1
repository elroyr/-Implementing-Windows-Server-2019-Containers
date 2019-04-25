#Download the docker engine archive (a machine connected to the internet)
Invoke-WebRequest -UseBasicParsing -OutFile docker-18.09.1.zip https://download.docker.com/components/engine/windows-server/18.09/docker-18.09.1.zip

#Extract the archive in C:\Program Files
Expand-Archive docker-18.09.1.zip -DestinationPath $Env:ProgramFiles -Force

#Remove it
Remove-Item -Force docker-18.09.1.zip

#Install the containers feature
Install-WindowsFeature containers

#Modify the path environment variable to include the Docker folder
$newPath = "$env:ProgramFiles\docker;" + [Environment]::GetEnvironmentVariable("PATH",[EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("PATH", $newPath,[EnvironmentVariableTarget]::Machine)

#Restart the container host
Restart-Computer

#Register the docker deamon as a service
dockerd --register-service

#Start the Docker service
Start-Service docker

#Test that docker works
docker version
