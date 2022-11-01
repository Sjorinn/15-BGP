# Part 2

Name | IP Adress | Subnet Mask
---- | --------- | -----------
router_pde-bakk-1 | 10.1.1.1 | 24
router_pde-bakk-2 | 10.1.1.2 | 24
host_pde-bakk-1 | 30.1.1.1 | 24
host_pde-bakk-2 | 30.1.1.2| 24

Step 1:
Take our template router-[INTRA_NAME] and change the amount of adapters to at least 2.
Drag and drop 1 Ethernet Switch, 2 of our routers and 2 of our hosts to our project, idem dito for 2 of our hosts.
And start all of our devices.

Step 2:
For the first router:
* ip link add br0 type bridge
* ip link set dev br0 up
* ip addr add 10.1.1.1/24 dev eth0
	* ip addr show eth0
* ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
* ip addr add 20.1.1.1/24 dev vxlan10
	* ip -d link show vxlan10
* brctl addif br0 eth1
* brctl addif br0 vxlan10
* ip link set dev vxlan10 up
	* ip -d link show vxlan10

And now (roughly) the same for our second router:
* ip link add br0 type bridge
* ip link set dev br0 up
* ip addr add 10.1.1.2/24 dev eth0
* ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.1 local 10.1.1.2 dstport 4789
* ip addr add 20.1.1.2/24 dev vxlan10
* ip link set dev vxlan10 up
	* ip -d link show vxlan10
* brctl addif br0 eth1
* brctl addif br0 vxlan10

First host:
* ip addr add 30.1.1.1/24 dev eth1

Second host:
* ip addr add 30.1.1.2/24 dev eth1
