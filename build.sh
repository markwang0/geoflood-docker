#!/bin/bash

# build multi-architecture amd64 & arm64 
# geoflood docker image and push to dockerhub
# see Dockerfile in this directory

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag markwang0/geoflood:latest \
    --push .
