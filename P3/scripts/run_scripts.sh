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
	echo "Copying script to router_pde-bakk-$i and executing it."
	docker cp ./scripts/config_router${i}.sh router_pde-bakk-${i}:/root
	docker exec -i router_pde-bakk-${i} /root/config_router${i}.sh
done

for i in $(seq 1 $AMOUNT_HOSTS)
do
	echo "Copying script to host_pde-bakk-$i and executing it."
	docker cp ./scripts/config_host${i}.sh host_pde-bakk-${i}:/root
	docker exec -i host_pde-bakk-${i} /root/config_host${i}.sh
done
