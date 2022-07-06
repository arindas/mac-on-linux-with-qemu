# mac-on-linux-with-qemu
![screenshot](./assets/screenshot.png)

[![License: MIT](https://img.shields.io/github/license/arindas/mac-on-linux-with-qemu)](https://opensource.org/licenses/MIT)
![Repo size](https://img.shields.io/github/repo-size/arindas/mac-on-linux-with-qemu)

Runs macOS on linux with qemu.

## Dependencies

- `qemu-system-x86_64`
- `dmg2img`
- `pulseaudio`
- `python[click]`

## Usage

After cloning the repository, simply run [`./run.sh`](./run.sh)

## How does it work?

-  [`./fetch-macos.py`](./fetch-macos.py) fetches macOS image dmg from their software update centre
-  The downloaded .dmg image is converted to .img using the `dmg2img` utility
-  We create a virtual disk image using [`./create-virtual-disk.sh`](./create-virtual-disk.sh)
-  We install macOS to qemu using the given image. [`./install-macos.sh`](./install-macos.sh)
-  We provide a custom launcher script to launch qemu with the correct settings. [`./launch-macos.sh`](./launch-macos.sh)

## Closed issues solving relevant tasks
- [Xcode and usb iphone passthrough for ios App development](https://github.com/arindas/mac-on-linux-with-qemu/issues/25)

## Closed issues solving common problems
- [archlinux: virtio-vga support lost after qemu and kernel upgrade](https://github.com/arindas/mac-on-linux-with-qemu/issues/24)
- [Freeze on Big Sur using the new ESP.qcow2 resolved](https://github.com/arindas/mac-on-linux-with-qemu/issues/21)

## References
- https://github.com/popey/sosumi-snap

## License
This repository is licensed under the MIT License. See [LICENSE](./LICENSE) for the full license text.
