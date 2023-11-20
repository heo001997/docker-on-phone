#!/bin/bash

# Assign command-line arguments to variables
memory=$1
cpus=$2

qemu-system-x86_64 -machine q35 -m $memory -smp cpus=$cpus -cpu qemu64 \
  -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd \
  -netdev user,id=n1,hostfwd=tcp::10022-:22,hostfwd=tcp::10080-:80,hostfwd=tcp::18080-:8080,hostfwd=tcp::10443-:443,hostfwd=tcp::13000-:3000,hostfwd=tcp::13035-:3035 \
  -device virtio-net,netdev=n1 \
  -fsdev local,id=fsdev0,path=$PREFIX/share/virtual_mount,security_model=mapped \
  -device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare \
  -nographic alpine.img
