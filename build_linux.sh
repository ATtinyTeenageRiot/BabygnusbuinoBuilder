#!/bin/bash
REMOTE="root@localhost"
PORT="9999"
HELLO="world"

REPO_DIR="/root/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="./staging/avrdude"

COMMIT_HASH="9f037f21"

ssh ${REMOTE} -p ${PORT} bash -c "'

cd "${REPO_DIR}/avrdude-6.0rc1-patched"

git fetch --all
git pull --all
git reset --hard ${COMMIT_HASH}
git clean -dfx

#make clean
./configure --silent > /dev/null
make

patchelf --set-rpath ./ ./avrdude
patchelf --print-rpath ./avrdude

cp "/lib/libusb-0.1.so.4" .
cp "/lib/libusb-1.0.so.0" .
cp "/lib/libncurses.so.5" .

git log -1 > changelog.txt

'"

mkdir -p ${DESTINATION_REPO}/linux
scp -P ${PORT} ${REMOTE}:${REPO_DIR}/avrdude-6.0rc1-patched/\{avrdude,changelog.txt,libusb-0.1.so.4,libusb-1.0.so.0,libncurses.so.5\} ${DESTINATION_REPO}/linux