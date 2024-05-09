#!/bin/bash

docker system prune --all --force --volumes

export ANDROID_NDK_HOME=~/android-ndk-r20b
export ANDROID_HOME=~/android
export AWS_LC=true
export FIPS=true

git submodule update --init

if [ -z ${FIPS} ]; then
    FIPS=false
fi

DISTRO=android

BUILD_COMMAND="FIPS=${FIPS} ./build_android_fat.sh $*"

echo "Building android using distro: $DISTRO and command $BUILD_COMMAND"

docker build -t crypto-${DISTRO} -f docker/${DISTRO}/Dockerfile .
docker run \
    -e ARTIFACTORY_URL=${ARTIFACTORY_URL} \
    -e ARTIFACTORY_USER=${ARTIFACTORY_USER} \
    -e ARTIFACTORY_PASS=${ARTIFACTORY_PASS} \
    --name crypto-${DISTRO}-instance crypto-${DISTRO} \
    /bin/sh -c "${BUILD_COMMAND}"

exit $?
