# https://hub.docker.com/_/golang
FROM --platform=$BUILDPLATFORM golang:1.23-alpine AS build

RUN mkdir /output
WORKDIR /src
COPY . .

RUN <<EOF
  if [ ! -f go.mod ] || [ ! -f go.sum ];then
    go mod init 'github.com/go-cross-build'
    go mod tidy
  fi

  if [ -f go.mod ] && [ -f go.sum ];then
    go mod download
  else
    go env -w GO111MODULE=off
  fi
EOF

ARG APP_NAME="app"
ARG APP_PKG="."
ARG TARGETOS TARGETARCH
RUN <<EOF
  export GOOS=$TARGETOS
  export GOARCH=$TARGETARCH

  OUT="/output/${APP_NAME}-${TARGETOS}-${TARGETARCH}"
  [ "$TARGETOS" = 'windows' ] && OUT="${OUT}.exe"

  go build -o "$OUT" "$APP_PKG"
EOF

FROM scratch AS release
COPY --from=build /output .
