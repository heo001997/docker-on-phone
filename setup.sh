#!/bin/bash

./download_alpine_latest.sh
sudo expect up_image.expect 6 6 64
sudo expect up_virtual.expect 6 6
sudo ./start_virtual.sh 6 6
