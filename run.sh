#!/bin/bash

docker run --privileged -v /var/lib/docker:/var/lib/docker -v `pwd`/mount/:/host -t -i docker-host /host/wrapdocker

