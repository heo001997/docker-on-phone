#!/bin/bash

./download_alpine_latest.sh
./up_image.expect 6 6144 64
./up_internet.sh
setup-alpine -f answerfile
# Other Option choose default,
# Except Erase the above disk(s) and continue? => YES
poweroff
./up_virtual.sh 6 6144
./up_internet.sh
./up_docker.sh
docker run -d --name my-nginx -p 8000:80 nginx
