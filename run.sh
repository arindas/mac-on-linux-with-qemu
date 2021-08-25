#!/bin/bash

# Bash strict mode, exit on failing command
set -e

echo "*** Checking for firmware files"
if [ ! -f firmware/OVMF_VARS-1024x768.fd ]; then
	mkdir firmware
	cp -a packaged-firmware/OVMF_VARS-1024x768.fd firmware/
fi

echo "*** Checking for Base System files"

echo "*** Check if dmg2img is available"
which dmg2img

echo "*** Check if BaseSystem dmg is downloaded. If downloaded convert to img"
if [ ! -f BaseSystem/BaseSystem.dmg ]; then
	echo "*** Downloading BaseSystem dmg"
	if python3 fetch-macos.py -o BaseSystem "$@"; then
		echo "*** BaseSystem dmg downloaded."
	else
		echo "Failed to download base system."
		exit 1
	fi
fi
echo "*** BaseSystem dmg available."

echo "*** Check if BaseSystem dmg has been converted to img before."
if [ ! -f BaseSystem/BaseSystem.img ]; then
	echo "*** Converting BaseSystem dmg to img."
	dmg2img BaseSystem/BaseSystem.dmg BaseSystem/BaseSystem.img
fi
echo "*** BaseSystem img available."


echo "*** Checking for disk image"
if [ ! -f macos.qcow2 ]; then
	qemu-img create -f qcow2 macos.qcow2 64G
fi

echo "*** Check if installer has been run"
# Probably a better way to do this, but checking the size of the macos qcow is probably best.
# If it's over an arbitrary size, we can guess the install finished
# On my machine a basic qcow is 262192 bytes, but let's put a buffer of 2x that
qcowfilesize=$(stat -c %s macos.qcow2)
if [ $qcowfilesize -gt 524384 ]; then
  echo "*** Looks like the install was done, launching"
  echo "*** Launch!"
  exec ./launch-macos.sh
else
  echo "*** Looks like the install hasn't been done yet, lets install"
  echo "*** Install!"
  exec ./install-macos.sh
fi

