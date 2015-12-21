#!/bin/bash
REMOTE=""
PORT=""

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_DIR="staging/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="releases/AvrdudeGnusbuinoMidi2Kicker"
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

rm -fr "${cwd}/${DESTINATION_REPO}/osx/*"

cp ./avrdude "${cwd}/${DESTINATION_REPO}/osx"
cp ./avrdude.conf "${cwd}/${DESTINATION_REPO}/osx"
cp ./changelog.txt "${cwd}/${DESTINATION_REPO}/osx"

cp "/usr/local/opt/libusb/lib/libusb-1.0.0.dylib" "${cwd}/${DESTINATION_REPO}/osx"

cd "${cwd}/${DESTINATION_REPO}/osx"

chmod 755 "./libusb-1.0.0.dylib"
install_name_tool -change  /usr/lib/libedit.3.dylib /usr/lib/libedit.2.dylib ./avrdude
install_name_tool -change "/usr/local/opt/libusb/lib/libusb-1.0.0.dylib" "@executable_path/libusb-1.0.0.dylib" ./avrdude
install_name_tool -id "@executable_path/libusb-1.0.0.dylib" ./libusb-1.0.0.dylib
