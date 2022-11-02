#!/usr/bin/env bash

running_containers=$(docker ps -q)
if [[ ! -z $running_containers ]]
then
  for i in ${running_containers[@]}
  do
	hostname=$(docker exec $i hostname)
	echo "Renaming $i to $hostname"
	docker rename "$i" "$hostname"
  done
else
  echo "No running containers"
  exit 1
fi
AMOUNT_ROUTERS=4
AMOUNT_HOSTS=3

for i in $(seq 1 $AMOUNT_ROUTERS)
do
	echo "Copying script to router_$USER-$i and executing it."
	docker cp ./scripts/config_router${i}.sh router_${USER}-${i}:/root
	docker exec -i router_${USER}-${i} /root/config_router${i}.sh
done

for i in $(seq 1 $AMOUNT_HOSTS)
do
	echo "Copying script to host_$USER-$i and executing it."
	docker cp ./scripts/config_host${i}.sh host_${USER}-${i}:/root
	docker exec -i host_${USER}-${i} /root/config_host${i}.sh
done
