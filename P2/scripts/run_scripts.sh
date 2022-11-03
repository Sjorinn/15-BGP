#!/usr/bin/env bash

#Script to exec the config script inside each container

#Every running containers into a var
running_containers=$(docker ps --format "{{.Names}}")

#If there is Running containers
if [[ ! -z $running_containers ]]
then
# Then Rename them
  for i in ${running_containers[@]}
  do
	hostname=$(docker exec $i hostname)
	if [[ "$i" != "$hostname" ]]; then
		echo "Renaming $i to $hostname"
		docker rename "$i" "$hostname"
	fi
  done
else
  echo "No running containers"
  exit 1
fi

# Then for each individual Docker container, copy the corresponding script in it and exec it

docker cp ./scripts/config_router1.sh router_pde-bakk-1:/root/
docker exec -it router_pde-bakk-1 /root/config_router1.sh

docker cp ./scripts/config_router2.sh router_pde-bakk-2:/root/
docker exec -it router_pde-bakk-2 /root/config_router2.sh

docker cp ./scripts/config_host1.sh host_pde-bakk-1:/root/
docker exec -it host_pde-bakk-1 /root/config_host1.sh

docker cp ./scripts/config_host2.sh host_pde-bakk-2:/root/
docker exec -it host_pde-bakk-2 /root/config_host2.sh
