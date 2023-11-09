#!/bin/bash

if [ $# -lt 3 ]; then
  echo "Usage: $0 <cpus> <ram-in-MB> <hard-disk-in-GB>"
  exit 1
fi

CPUS=$1
MEMORY=$2
HARD_DISK=$3

qemu-img create -f qcow2 alpine.img "$HARD_DISK"G

qemu-system-x86_64 -machine q35 -m "$MEMORY" -smp cpus="$CPUS" -cpu qemu64 \
  -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom alpine-virt-*-x86_64.iso \
  -nographic alpine.img
