# README

This repo hosts an assortment of container files I use.

## General notes

- The files for building the containers begin with `Containerfile` or
  `Dockerfile` and may contain extensions to indicate whether it is a
  multistage build or not, among other stuff.
- The podman container tool is used to build and run the containers. If you
  are using some other tool, like docker, you may need to tweak the
  Containerfiles.

## Container descriptions

- `airplay_server`: An airplay server programmed in Java.
- `iosevka_font`: A build environment for building a favorite font of mine
  called Iosevka.
- `latex`: A less bloated LaTeX environment in Debian. Does not include
  documentation and other language packs besides English.
- `makepkg`: An Arch Linux environment to build packages from PKGBUILD files.

## Licensing

Works in this repo are licensed under CC0 with a few exceptions. Exceptions
contain a separate license file in their folder.
