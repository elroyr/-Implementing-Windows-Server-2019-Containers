#Steps for the interactive method
#Start th servercore image in interactive mode
docker run -it mcr.microsoft.com/windows/servercore:ltsc2019 powershell

#Install the iss role
Install-WindowsFeature Web-Server

#Modify the issstart.htm file
Set-Content -Value "<b>Hello from a container built interactively</b>" -Path C:\inetpub\wwwroot\iisstart.htm

#Exit the container
exit

#Get the ID of the container
docker ps -a

#Save the changes to a new image
docker commit <id> iis1

#Run the new image
docker run -d -p 81:80 iis1 ping -t localhost

#Now the steps for the dockerfile method
#Create a folder to build our second image using a dockerfile
#Copy the dockerfile from the code directory in the container host
mkdir C:\Build
cd c:\Build

#Build the image using the dockerfile
docker build -t iis2 .

#Run the image
docker run -d -p 82:80 iis2