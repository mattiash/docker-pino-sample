#!/bin/sh
set -x

UUID=`uuidgen`
IMAGE=test
echo $UUID
docker build --target build -t $IMAGE:$UUID .
docker run --name $UUID $IMAGE:$UUID npm run test
docker cp $UUID:/usr/src/app/build/test/*.tap .
# docker rm $UUID
docker image rm $IMAGE:$UUID
