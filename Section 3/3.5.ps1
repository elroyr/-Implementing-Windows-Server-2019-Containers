#Enable the experimental feature for docker
Set-Content -Path C:\ProgramData\docker\config\daemon.json -Value @"
{
  "experimental" : true
}
"@

#Restart the service so the new configuration can take effect
Restart-Service docker

#Download the Linux kernel for our containers
Invoke-WebRequest -Uri "https://github.com/linuxkit/lcow/releases/download/v4.14.35-v0.3.9/release.zip" -UseBasicParsing -OutFile release.zip
Expand-Archive release.zip -DestinationPath "$Env:ProgramFiles\Linux Containers\."

#Download and run a linux container based on ubuntu
docker run -it --platform=linux ubuntu bash