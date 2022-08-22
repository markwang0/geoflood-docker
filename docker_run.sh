#!/bin/bash

# do nothing if no arguments are provided
if [ $# -eq 0 ]; then
    exit 1
fi

docker run \
    --name geoflood-bash --rm -it \
    --mount type=bind,source="$(pwd)",target="/mnt/host" \
    test_image bash -c \
        "cd /mnt/host && $*"
