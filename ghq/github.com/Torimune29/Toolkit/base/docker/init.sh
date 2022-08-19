#!/bin/bash

set -eu

if [ ! -x "$(command -v docker)" ]; then
  curl -fsSL get.docker.com | sh
  if [ "${USER:-root}" != "root" ]; then
    if [ -x "$(command -v sudo)" ]; then sudo -S -E gpasswd -a ${USER} docker
    elif [ -x "$(command -v su)" ]; then su - -c gpasswd -a ${USER} docker; fi
  fi
fi
