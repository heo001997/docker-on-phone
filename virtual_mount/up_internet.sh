#!/bin/ash

setup-interfaces -a
ifup eth0
echo "nameserver 1.1.1.1" > /etc/resolv.conf
mkdir -p /etc/udhcpc
touch /etc/udhcpc/udhcpc.conf
echo "RESOLV_CONF=no" > /etc/udhcpc/udhcpc.conf
