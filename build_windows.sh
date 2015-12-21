#!/bin/bash
REMOTE="xcorex@172.16.225.131"
PORT="22"
HELLO="world"

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="/c/Users/xcorex/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="./staging/avrdude"

COMMIT_HASH="0.0.1"
ssh ${REMOTE} -p ${PORT} bash -c "'

rm -fr "${REPO_DIR}"
git clone ${REPO_URL}

cd ${REPO_DIR}
git checkout ${COMMIT_HASH}
git log -1
ls "${REPO_DIR}"

cd "${REPO_DIR}/babygnusbsysex"
mkdir "Release"
make clean
make

cd "${REPO_DIR}/avrdude-6.0rc1"

#make clean
./configure
make

mkdir -p "../release""
cp ./avrdude.exe ../release

git log -1 > changelog.txt

'"

mkdir -p ${DESTINATION_REPO}/windows
scp -P ${PORT} ${REMOTE}:${REPO_DIR}/release/\{avrdude.exe,libusb0.dll\} ${DESTINATION_REPO}/windows