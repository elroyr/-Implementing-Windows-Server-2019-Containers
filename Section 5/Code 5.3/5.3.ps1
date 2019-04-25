###To be run on the host that will have the registry container
#Get the docker image for an on premises registry
docker pull stefanscherer/registry-windows

#Create a folder for the image store
mkdir C:\Images

#Run the container with the 5000 port, restart policy set to always and mapping C:\Images from the host to C:\registry in the container
docker run -d -p 5000:5000 --restart=always --name registry -v C:\Images:C:\registry stefanscherer/registry-windows

#Prepare an image to be imported on another docker host
docker save -o "C:\nano.tar" mcr.microsoft.com/windows/nanoserver:1809


###To be run on the 'client' container host
#Copy the archive to the other container host
Copy-Item \\chost02\c$\nano.tar C:\nano.tar

#Load the image
docker load -i C:\nano.tar

#Edit the docker config file to point to this new registry
notepad C:\ProgramData\docker\config\daemon.json
#Add the following:
{
  	"insecure-registries": ["192.168.1.5:5000"],
	"allow-nondistributable-artifacts": ["192.168.1.5:5000"]
}

#Now restart the Docker service
Restart-Service docker

#Tag an image for your own registry
docker tag mcr.microsoft.com/windows/nanoserver:1809 192.168.1.5:5000/nano:1809

#Push the new image to the registry
docker push 192.168.1.5:5000/nano:1809

#Remove the base image and the tagged one
docker rmi mcr.microsoft.com/windows/nanoserver:1809 -f

#Pull image from the internal registry
docker pull 192.168.1.5:5000/nano:1809