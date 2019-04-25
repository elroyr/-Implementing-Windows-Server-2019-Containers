#Get a list of Docker networks
docker network ls

#Get a list of Hyper-V switches
Get-VMSwitch

#Get information about a docker network
docker network inspect nat

#See options for creating a new network
docker network create --help

#To connect a container to a network just use --network
#docker run --network