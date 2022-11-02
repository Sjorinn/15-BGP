#!/usr/bin/env ash

#Create the bridge  and set it up
ip link add br0 type bridge
ip link set dev br0 up

#Add ip address on eth0 interface
ip addr add 10.1.1.1/24 dev eth0

# This line is for the static part: 
### ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
# And this one is for dynamic:
ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789

# add ip address on the new vxlan
ip addr add 20.1.1.1/24 dev vxlan10
# add all the interfaces to the bridge
brctl addif br0 eth1
brctl addif br0 vxlan10
# Set up de vxlan
ip link set dev vxlan10 up
