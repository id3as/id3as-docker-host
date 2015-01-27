#!/bin/bash

COMMAND=${1-"/sbin/my_init --enable-insecure-key"}
docker run --privileged -v /var/lib/docker:/var/lib/docker -v `pwd`/mount/:/host -t -i docker-host $COMMAND

