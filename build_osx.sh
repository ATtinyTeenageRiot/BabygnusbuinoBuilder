#!/bin/bash
REMOTE=""
PORT=""

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="tools/staging/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="tools/release/avrdude"
STAGING_DIR="tools/staging"

COMMIT_HASH="894d2178"

#rm -fr "${REPO_DIR}"
mkdir -p "${cwd}/${REPO_DIR}"
cd "${cwd}/${REPO_DIR}"

#git clone "${REPO_URL}"
git fetch --all
git pull --all
git checkout ${COMMIT_HASH}
git reset --hard ${COMMIT_HASH}

cd "${cwd}/${REPO_DIR}/avrdude-6.0rc1"
pwd
chmod +x ./configure
./configure
make
pwd

git log -1 > changelog.txt

mkdir -p "${cwd}/${DESTINATION_REPO}/osx"
cp ./avrdude "${cwd}/${DESTINATION_REPO}/osx"
cp ./avrdude.conf "${cwd}/${DESTINATION_REPO}/osx"
cp ./changelog.txt "${cwd}/${DESTINATION_REPO}/osx"
