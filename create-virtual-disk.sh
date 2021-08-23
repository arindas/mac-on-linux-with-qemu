#!/bin/sh

# Bash strict mode, exit on failing command
set -e

# create virtual hard disk
qemu-img create -f qcow2 macos.qcow2 64G
