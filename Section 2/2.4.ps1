#Pull the image for Windows Server 2019
docker pull mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

#Run the image. -d stands for deamon mode and -p is used to associate host ports with container ports
docker run -d -p 80:80 mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2019

#Get the running containers
docker ps

#Execute the powershell.exe program in interactive mode on the container
docker exec -it <container id> powershell

#Modify the main html file for the default website
'<h1>Hello World!</h1>' > C:\inetpub\wwwroot\iisstart.htm

#Exit the container
exit

#Stop the container
docker stop <container id>