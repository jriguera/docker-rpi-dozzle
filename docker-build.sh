#!/usr/bin/env bash

DOCKER=docker
NAME="dozzle"

ARCH=""
case "$(uname -m)" in
    armv7l)
        ARCH='arm32v6'
    ;;
    x86_64|amd64)
        ARCH='amd64'
    ;;
    *)
        echo "ERROR: unsupported architecture: $(uname -m)"
        exit 1
    ;;
esac

pushd docker
    $DOCKER build \
      --build-arg ARCH=${ARCH} \
      --build-arg TZ=$(timedatectl  | awk '/Time zone:/{ print $3 }') \
      .  -t $NAME
popd

