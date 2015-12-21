#!/bin/bash
REMOTE="root@localhost"
PORT="9999"

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="/root/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="./releases/AvrdudeGnusbuinoMidi2Kicker"
STAGING_DIR="./tools/staging"

COMMIT_HASH="894d2178"

ssh ${REMOTE} -p ${PORT} bash -c "'

rm -fr "${REPO_DIR}"
git clone ${REPO_URL}
cd ${REPO_DIR}
git checkout ${COMMIT_HASH}
git log -1
ls "${REPO_DIR}"


cd "${REPO_DIR}"
git fetch --all
git pull --all
git reset --hard ${COMMIT_HASH}
git clean -dfx

cd "${REPO_DIR}/avrdude-6.0rc1"
chmod +x configure


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
scp -P ${PORT} ${REMOTE}:${REPO_DIR}/avrdude-6.0rc1/\{avrdude,changelog.txt,libusb-0.1.so.4,libusb-1.0.so.0,libncurses.so.5\} ${DESTINATION_REPO}/linux