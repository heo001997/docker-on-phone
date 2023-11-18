#!/bin/ash

setup-interfaces -a
ifup eth0
echo "nameserver 1.1.1.1" > /etc/resolv.conf
