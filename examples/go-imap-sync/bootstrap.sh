#!/usr/bin/env bash

set -eu -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PATH="${DIR}/../../bin:${PATH}"

GIT_URL='https://github.com/JohannesEbke/go-imap-sync/archive/refs/heads/master.zip'
GIT_DIR='go-imap-sync-master'

export APP_NAME='go-imap-sync'
export APP_PKG='./cmd/go-imap-sync'
export OUT="${DIR}/release"
export XTRA_DOCKER_OPTS=(--no-cache)

TMP_DIR="${DIR}/tmp"

[ -d "$TMP_DIR" ] && rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

wget --no-check-certificate -O "${GIT_DIR}.zip" "$GIT_URL"
unzip "${GIT_DIR}.zip"
cd "$GIT_DIR"

# run script (found in PATH)
go-cross-build.sh

# reconfigure to support legacy versions of Windows
cp "${DIR}/go-1.20.mod" ./go.mod
export GO_VER='1.20'
export PLATFORM='windows/386,windows/amd64'
export OUT="${OUT}/legacy"

# run script (again)
go-cross-build.sh

# cleanup
cd "$DIR"
rm -rf "$TMP_DIR"
