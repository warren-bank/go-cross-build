### [go-cross-build](https://github.com/warren-bank/go-cross-build)

[_bash script_](./bin/go-cross-build.sh) and [_Dockerfile_](./bin/Dockerfile) to perform a multi-platform build for Golang projects.

* the primary goal is simplicity and ease of use
  - there are other tools that use Docker to cross-compile Golang projects,<br>but without being willing to dig into extensive documentation&hellip;<br>I found them complicated and confusing

#### Requirements

* [_Docker_](https://www.docker.com/)
* [_buildx_](https://github.com/docker/buildx)
* [create custom builder](https://docs.docker.com/build/building/multi-platform/#prerequisites)
  - ex: [_create-custom-builder.sh_](./requirements/create-custom-builder.sh)
* [install QEMU](https://docs.docker.com/build/building/multi-platform/#qemu)
  - ex: [_install-qemu.sh_](./requirements/install-qemu.sh)

#### [_go-cross-build.sh_](./bin/go-cross-build.sh)

* pre-conditions
  - the current working directory is the root of the Golang project to cross-compile

* environment variables
  - `GO_VER`
    * Golang compiler version
    * default value: `1.23`
    * note: compatibility with versions of Windows older than _Win10_ requires Golang compiler version [`1.20`](https://github.com/golang/go/issues/57003) or older
  - `OUT`
    * path to output directory
    * default value: `./dist`
  - `APP_NAME`
    * base name of output binary files
    * default value: `app`
  - `APP_PKG`
    * path to input package
    * default value: `.`
  - `PLATFORM`
    * comma separated list of target platforms
    * default value: `linux/386,linux/amd64,linux/arm,linux/arm64,windows/386,windows/amd64`
  - `XTRA_DOCKER_OPTS`
    * a _bash_ array of extra options to pass to `docker build`
    * default value: `()`
    * note: a string value is treated as an array with one element
    * example:
      ```bash
        export XTRA_DOCKER_OPTS=(--no-cache)
      ```

* copies [_Dockerfile_](./bin/Dockerfile) to the current working directory
* uses [_Docker_](https://www.docker.com/) with [_buildx_](https://github.com/docker/buildx) to perform cross-compile
  - environment variables are used for various parameters and build arguments

#### Examples

* [_go-imap-sync_](./examples/go-imap-sync/bootstrap.sh)
  - creates a temporary directory
  - downloads a snapshot of a [git repo](https://github.com/JohannesEbke/go-imap-sync)
  - changes the current working directory
  - assigns appropriate values to the environment variables
  - runs: [_go-cross-build.sh_](./bin/go-cross-build.sh)

#### References

* [Multi-platform builds](https://docs.docker.com/build/building/multi-platform/)
* [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)

#### Legal

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
