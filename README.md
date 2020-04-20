DistCC for ARM cross-compilation
================================

This repository presents a ready-to-deploy solution to cross-build Archlinux
packages through distcc.

Currently this has been tested on a Raspberry Pi B as a distcc client and a
x86_64 machine running this docker-compose file as a distcc host.

Currently only armv6h is supported, using the Archlinux toolchain. Other
distributions or toolchains can be supported if contributed, but please keep
them either in different Dockerfiles or using ENV so that at build time we can
package each toolchain in a different instance to avoid bloating the image sizes.

Keep in mind that we don't need to upload all images, since anyone can
use `docker-compose up --build` to build their own custom version, depending on
the specific environment variables used for the build, in the future.


Contributions
=============

Contributions are welcome. It'd rather use
[Gitlab Merge Requests](https://gitlab.com/ssaavedra.eu/distcc-arm/-/merge_requests)
if possible.

All contributions are expected to be either MIT licensed or CC0.
