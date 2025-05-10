#!/usr/bin/env bash

# https://docs.docker.com/build/building/multi-platform/#install-qemu-manually

docker run --privileged --rm tonistiigi/binfmt --install all
