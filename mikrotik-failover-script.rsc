:local gateway1 [/ip dhcp-client get [find interface="ether1"] gateway]
:local gateway2 [/ip dhcp-client get [find interface="ether2"] gateway]

/ip route add dst-address=0.0.0.0/0 gateway=8.8.8.8 target-scope=12 distance=1
/ip route add dst-address=0.0.0.0/0 gateway=1.1.1.1 target-scope=12 distance=2
/ip route add dst-address=8.8.8.8/32 gateway=$gateway1 scope=10 check-gateway=ping
/ip route add dst-address=1.1.1.1/32 gateway=$gateway2 scope=10 check-gateway=ping

