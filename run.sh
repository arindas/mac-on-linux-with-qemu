#!/bin/bash

echo "*** Checking for Base System files"
if [ ! -f BaseSystem/BaseSystem.img ]; then
	if python3 fetch-macos.py -o BaseSystem "$@"; then
		dmg2img BaseSystem/BaseSystem.dmg BaseSystem/BaseSystem.img
		# rm BaseSystem/BaseSystem.dmg
	else
		echo "Failed to download base system"
		exit 1
	fi
fi	

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
  exec launch-macos.sh
else
  echo "*** Looks like the install hasn't been done yet, lets install"
  echo "*** Install!"
  exec install-macos.sh
fi

