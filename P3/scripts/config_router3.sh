#!/usr/bin/env ash

# Create and up the vxlan and the bridge
ip link add br0 type bridge
ip link set dev br0 up
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set dev vxlan10 up

# Add the bridge on the vxlan and the eth0
brctl addif br0 vxlan10
brctl addif br0 eth0

# Launch the Shell for the routing daemons configuration
vtysh <<EOF
conf t
no ipv6 forwarding
!
interface eth1
# Create an ip for the interface and run ospf on the the interface for the configured ip
 ip address 10.1.1.6/30
 ip ospf area 0
!
interface lo
# Create an ip for the interface and run ospf on the the interface for the configured ip  
 ip address 1.1.1.3/32
 ip ospf area 0
!
router bgp 1
# Create neighbor initiate the connexion and add it to the pgp
 neighbor 1.1.1.1 remote-as 1
# Set the source as Loopback interface for bgp package sent, so that if the first neighbor is dowm the other will the shift 
 neighbor 1.1.1.1 update-source lo
 !
 #####
 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
!
# Turn on ospf on the router
router ospf

end
EOF
