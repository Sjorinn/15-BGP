#!/usr/bin/env bash

#Log each running containers in var
running_containers=$(docker ps --format "{{.Names}}")
#If there is running containers
if [[ ! -z $running_containers ]]
then
# Rename them
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

AMOUNT_ROUTERS=4
AMOUNT_HOSTS=3

#Copy each script in each routeur and exec it
for i in $(seq 1 $AMOUNT_ROUTERS)
do
	echo "Copying script to router_pde-bakk-$i and executing it."
	docker cp ./scripts/config_router${i}.sh router_pde-bakk-${i}:/root
	docker exec -i router_pde-bakk-${i} /root/config_router${i}.sh
done

#Copy each script in each host and exec it
for i in $(seq 1 $AMOUNT_HOSTS)
do
	echo "Copying script to host_pde-bakk-$i and executing it."
	docker cp ./scripts/config_host${i}.sh host_pde-bakk-${i}:/root
	docker exec -i host_pde-bakk-${i} /root/config_host${i}.sh
done
