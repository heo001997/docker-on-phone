#!/bin/bash

qemu-system-x86_64 -machine q35 -m 6144 -smp cpus=8 -cpu qemu64 \
  -drive if=pflash,format=raw,read-only=on,file=$PREFIX/share/qemu/edk2-x86_64-code.fd \
  -netdev user,id=n1,hostfwd=tcp::2222-:22,hostfwd=tcp::8000-:8000 \
  -device virtio-net,netdev=n1 \
  -nographic alpine.img
