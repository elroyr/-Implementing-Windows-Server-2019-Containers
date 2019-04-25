###Bind mounts
#Create 2 folders: first directly under C:\ and the other in the current user's documents
mkdir C:\test1
mkdir C:\Users\administrator.ADICORP\test2

#Let's check out the permissions for the 2 folders
#test1 permits access also to users while test2 permits access only to Administrators (besides System)
Get-Acl C:\test1 | Select-Object -ExpandProperty access
Get-Acl C:\Users\administrator.ADICORP\test2 | Select-Object -ExpandProperty Access

#Let's run a container and mount the test1 folder as C:\t
docker run -it -v C:\test1:C:\t mcr.microsoft.com/windows/nanoserver:1809
#Create a new folder in t and exit the container
mkdir C:\t\new
Exit
#Check the folder
dir C:\test1

#Now we run a container and mount test2 as t
docker run -it -v C:\Users\administrator.ADICORP\test2:C:\t mcr.microsoft.com/windows/nanoserver:1809
#Since the Users group is not in the ACL list we cannot even see what is in the folder
dir C:\t
Exit

#Let's try test2 using a Hyper-V container and create  folder
docker run -it --isolation=hyperv -v C:\Users\administrator.ADICORP\test2:C:\t mcr.microsoft.com/windows/nanoserver:1809
mkdir C:\t\new
Exit

#Check out test2
dir C:\Users\administrator.ADICORP\test2

#Clean up
Remove-Item C:\test1 -Recurse
Remove-Item C:\Users\administrator.ADICORP\test2 -Recurse


###Named volumes
#Create a named volume
docker volume create testVol

#See info about the volume
docker inspect testVol

#Check out the permisisons on the folder where the volume resides
Get-Acl C:\ProgramData\docker\volumes\testvol\ | Select-Object -ExpandProperty access

#Run a container and attach this named volume to it
docker run -it --rm -v testVol:C:\t mcr.microsoft.com/windows/nanoserver:1809
cd C:\t
Exit

#Now run the container with Hyper-V isolation
docker run -it --rm --isolation=hyperv -v testVol:C:\t mcr.microsoft.com/windows/nanoserver:1809
mkdir C:\t\new
Exit

#Delete the volume (you must delete the containers before even if they are stopped)
docker volume rm testVol

