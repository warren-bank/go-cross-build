ARG GO_VER="1.23"

# https://hub.docker.com/_/golang
FROM --platform=$BUILDPLATFORM golang:${GO_VER}-alpine AS build

RUN mkdir /output
WORKDIR /src
COPY . .

RUN <<EOF
  go env -w GO111MODULE=on

  if [ ! -f go.mod ] || [ ! -f go.sum ];then
    go mod init 'github.com/go-cross-build'
    go mod tidy
  fi

  if [ -f go.mod ] && [ -f go.sum ];then
    go clean -r -cache -modcache
    go mod download
  else
    go env -w GO111MODULE=off
    go clean -r -cache
  fi
EOF

ARG GO_VER="1.23"
ARG APP_NAME="app"
ARG APP_PKG="."
ARG TARGETOS TARGETARCH
RUN <<EOF
  export GOOS=$TARGETOS
  export GOARCH=$TARGETARCH

  OUT="/output/${APP_NAME}-go${GO_VER}-${TARGETOS}-${TARGETARCH}"
  [ "$TARGETOS" = 'windows' ] && OUT="${OUT}.exe"

  go build -o "$OUT" "$APP_PKG"
EOF

FROM scratch AS release
COPY --from=build /output .
