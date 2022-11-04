#!/usr/bin/env ash

vtysh <<EOF
conf t
no ipv6 forwarding
!
# Create interface for each router that the Route Reflector has to connect
interface eth0
 ip address 10.1.1.1/30
!
interface eth1
 ip address 10.1.1.5/30
!
interface eth2
 ip address 10.1.1.9/30
!
# Set the loopback adress to match the config of the other router
interface lo
 ip address 1.1.1.1/32
!
router bgp 1
# Create a a group of remote neighbor
 neighbor ibgp peer-group
# set remote number to the same as the local number
 neighbor ibgp remote-as 1
# Set the source to lo to force bgp to use 1.1.1.1 address when talking to neighbor, to match other router conf
 neighbor ibgp update-source lo
# Neighbor are defined by this ip range
 bgp listen range 1.1.1.0/29 peer-group ibgp

 # Enable the bgp evpn
 address-family l2vpn evpn
 # Enable exchange with all bgp neighbor
  neighbor ibgp activate
# Configure the local router as route reflector
  neighbor ibgp route-reflector-client
 exit-address-family
!
# Enable ospf
router ospf
# include all ip address from area 0 (see router 2 3 4 conf)
 network 0.0.0.0/0 area 0

end
EOF

# You could use 'write file' or 'write integrated' to save the changes
# To config files, but since the changes from the 'ip' commands get reset every time, we opted not to.
