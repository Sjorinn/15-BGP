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

docker cp ./scripts/config_router1.sh router_${USER}-1:/root/
docker exec -it router_${USER}-1 /root/config_router1.sh

docker cp ./scripts/config_router2.sh router_${USER}-2:/root/
docker exec -it router_${USER}-2 /root/config_router2.sh

docker cp ./scripts/config_host1.sh host_${USER}-1:/root/
docker exec -it host_${USER}-1 /root/config_host1.sh

docker cp ./scripts/config_host2.sh host_${USER}-2:/root/
docker exec -it host_${USER}-2 /root/config_host2.sh
