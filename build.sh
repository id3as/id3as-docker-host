#!/bin/bash

set -e

cd ${0%/*}

TMPDIR=$(mktemp -d /tmp/XXXXXXXX)
CIDFILE=$TMPDIR/cid
PWD=$(pwd)
PWD_ON_HOST="/home/id3as"${PWD#$HOME}
PROVISION_CMD="/host/provision-docker-host.sh"
BASE_IMAGE="id3as-baseimage:0.0.1"
IMAGE_NAME="docker-host"

docker run --cidfile=$CIDFILE -t -v $PWD/mount/:/host:ro $BASE_IMAGE /bin/bash -c $PROVISION_CMD

CID=$(cat $CIDFILE)
docker rmi $IMAGE_NAME >/dev/null 2>&1 || echo -n
IID=$(docker commit $CID $IMAGE_NAME)
docker rm $CID >/dev/null 2>&1
