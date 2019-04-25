#display docker system wide information
docker info

#list Docker images
docker images

#run docker images by passing the name
docker run -d mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019
#get help about docker run
docker run --help

#list running containers
docker ps
#list all containers (also stopped)
docker ps -a

#stop a docker container by name or id
docker stop <name or id>

#remove a container once it is stopped
docker rm <name or id>

#remove a container image
docker rmi <id>

#attach to the stdin, stdout and stderr consoles of a container
docker attach <id>

#copy files from the source to the destination using the container id (works from the host to the container and vice-versa)
#in this example first is the source and second is the container with the specified id
docker cp C:\build\ 48239b619705:C:\

#get data about the container
dokcer inspect <id or name>

#get a list of running processes from a container
docker top <id>

#execute commands in containers
docker exec <id> cmd.exe /c dir c:\
#it can also be used to enter a container if attach does not work
docker exec -it <id> powershell.exe