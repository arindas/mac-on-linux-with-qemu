# mac-on-linux-with-qemu

Runs macOS on linux with qemu.

## Pre-requisites

- `qemu-system-x86_64`
- `dmg2img`
- `pulseaudio`

## Usage

After cloning the repository, simply run `./run.sh`

## How it works

- [x] `./fetch-macos.py` fetches macOS image dmg from their software update centre
- [x] The downloaded .dmg image is converted to .img using the `dmg2img` utility
- [x] We create a virtual disk image using `./create-virtual-disk.sh`
- [x] We install macOS to qemu using the given image. `./install-macos.sh`
- [x] We provide a custom launcher script to launch qemu with the correct settings. `./launch-macos.sh`

## References
- https://github.com/popey/sosumi-snap
