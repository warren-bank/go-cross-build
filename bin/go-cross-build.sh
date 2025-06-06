#!/usr/bin/env bash

set -e -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PLATFORM="${PLATFORM:-linux/386,linux/amd64,linux/arm,linux/arm64,windows/386,windows/amd64}"
OUT="${OUT:-./dist}"

[ -d "$OUT" ] && rm -rf "$OUT"
mkdir -p "$OUT"

cp "${DIR}/Dockerfile" ./go-cross-build.Dockerfile

opts=()
opts+=(--file ./go-cross-build.Dockerfile)
[ -n "$GO_VER" ]   && opts+=(--build-arg "GO_VER=${GO_VER}")
[ -n "$APP_NAME" ] && opts+=(--build-arg "APP_NAME=${APP_NAME}")
[ -n "$APP_PKG" ]  && opts+=(--build-arg "APP_PKG=${APP_PKG}")
opts+=(--platform "$PLATFORM")
opts+=(--output "$OUT")
opts+=(--target release)

if [ -v XTRA_DOCKER_OPTS[0] ];then
  if [ "${#XTRA_DOCKER_OPTS[@]}" -gt "1" ];then
    opts+=("${XTRA_DOCKER_OPTS[@]}")
  elif [ -n "$XTRA_DOCKER_OPTS" ];then
    opts+=($XTRA_DOCKER_OPTS)
  fi
fi

docker buildx build "${opts[@]}" .
