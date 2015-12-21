#!/bin/bash
REMOTE="xcorex@172.16.225.134"
PORT="22"

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="/c/Users/xcorex/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="./tools/release/avrdude"
STAGING_DIR="./tools/staging"

COMMIT_HASH="894d2178"

ssh ${REMOTE} -p ${PORT} bash -c "'

#rm -fr "${REPO_DIR}"
#git clone ${REPO_URL}
#cd ${REPO_DIR}
#git checkout ${COMMIT_HASH}
#git log -1
#ls "${REPO_DIR}"

cd "${REPO_DIR}/babygnusbsysex"
mkdir "Release"
make clean
make

pwd

cd "${REPO_DIR}/avrdude-6.0rc1"
#make clean
#./configure
#make

cp avrdude.exe ../release
cp avrdude.conf ../release

git log -1 > ../release/changelog.txt

cd "${REPO_DIR}/release"
pwd
ls "${REPO_DIR}/release"

'"

mkdir -p ${DESTINATION_REPO}/windows
scp -P ${PORT} ${REMOTE}:${REPO_DIR}/release/* ${DESTINATION_REPO}/windows