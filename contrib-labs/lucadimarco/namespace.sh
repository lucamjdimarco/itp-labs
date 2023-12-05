#!/bin/bash

ip netns add ns2
ip netns exec ns2 ip link set lo up
ip link add veth0 type veth peer name veth1
ip link set veth1 netns ns2
ip link set veth0 up
ip netns exec ns2 ip link set veth1 up
ip addr add 10.0.0.100/24 dev veth0
ip netns exec ns2 ip addr add 10.0.0.101/24 dev veth1
ip netns exec ns2 ip route add default via 10.0.0.100

ip netns add ns3
ip netns exec ns3 ip link set lo up
ip link add veth2 type veth peer name veth3
ip link set veth3 netns ns3
ip link set veth2 up
ip netns exec ns3 ip link set veth3 up
ip addr add 192.168.10.100/24 dev veth2
ip netns exec ns3 ip addr add 192.168.10.101/24 dev veth3
ip netns exec ns3 ip route add default via 192.168.10.100
sysctl -w net.ipv4.ip_forward=1
sysctl net.ipv4.ip_forward

ip netns add ns4
ip netns exec ns4 ip link set lo up
ip link add veth4 type veth peer name veth5
ip link set veth5 netns ns4
ip link set veth4 up
ip netns exec ns4 ip link set veth5 up
ip addr add 192.168.11.100/24 dev veth4
ip netns exec ns4 ip addr add 192.168.11.101/24 dev veth5
ip netns exec ns4 ip route add default via 192.168.11.100

