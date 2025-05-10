#!/usr/bin/env bash

# https://docs.docker.com/build/building/multi-platform/#prerequisites

docker buildx create --name container-builder --driver docker-container --bootstrap --use
