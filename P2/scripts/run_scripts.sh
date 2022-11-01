#!/usr/bin/env bash

docker cp ./scripts/config_router1.sh router_pde-bakk-1:/root/
docker exec -it router_pde-bakk-1 /root/config_router1.sh

docker cp ./scripts/config_router2.sh router_pde-bakk-2:/root/
docker exec -it router_pde-bakk-2 /root/config_router2.sh

docker cp ./scripts/config_host1.sh host_pde-bakk-1:/root/
docker exec -it host_pde-bakk-1 /root/config_host1.sh

docker cp ./scripts/config_host2.sh host_pde-bakk-2:/root/
docker exec -it host_pde-bakk-2 /root/config_host2.sh
