#Run the nano server container in interactive mode
docker run -it mcr.microsoft.com/windows/nanoserver:1809
#Navigate the file system
dir
cd Windows 
dir
cd System32
dir *.exe
#Try a few commands
expand /?
hostname
ipconfig
sc query | findstr SERVICE_NAME
schtasks.exe /query

#Run the server core container in interactive mode
docker run -it mcr.microsoft.com/windows/servercore:ltsc2019 powershell
#Navigate the file system
dir
cd windows\system32
dir *.exe

whoami
Get-Process
Get-Service
Get-Service | Measure-Object
Get-ScheduledTask
Get-WindowsFeature | where {$_.installstate -ne 'Removed'}