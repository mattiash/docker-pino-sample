#!/bin/sh

rm -rf output
UUID=`uuidgen`
IMAGE=test
docker build --target build -t $IMAGE:$UUID .
docker run --name $UUID $IMAGE:$UUID npm run autotest
TEST_EXIT=$?
docker cp $UUID:/usr/src/app/build/test output
docker rm $UUID > /dev/null
exit $TEST_EXIT
