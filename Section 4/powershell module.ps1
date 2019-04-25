#get the module from: https://github.com/Microsoft/Docker-PowerShell/releases

#this module is not in development anymore so use it only if the available features are what you need

#list available commands in module
Get-Command -Module docker

#get list of containers
Get-Container

#stop a container
Stop-Container -Id <id>

#get a list of container images
Get-ContainerImage

#start a container
$image=Get-ContainerImage | where {$_.repotags -like "*windows:*"}
New-Container -Image $image -Command @("cmd", "/c", "ping -t localhost") | Start-Container

#execute commands in container
Get-Container | Exec-Container -Command @("cmd", "/c", "ipconfig")

#connect to a container's output stream
Get-Container | Enter-ContainerSession

#stop all containers
Get-Container | Stop-Container

#remove all containers
Get-Container | Remove-Container
