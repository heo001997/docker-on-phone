#!/bin/bash

# The base URL where the Alpine ISOs are hosted
BASE_URL="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/"

# Use wget to fetch the list of files from the BASE_URL
# Parse the output to find the most recent version of the alpine-virt ISO
# This assumes the directory listing is enabled on the server and wget can fetch it
LATEST_ISO=$(wget -qO- $BASE_URL | sed -n 's/.*alpine-virt-\([0-9.]*\)-x86_64.iso.*/\1/p' | sort -V | tail -n1)

# Construct the full URL for the latest ISO
FULL_URL="${BASE_URL}alpine-virt-${LATEST_ISO}-x86_64.iso"

# Use wget to download the latest ISO
wget $FULL_URL
