# Arch Linux makepkg environment

The files in this folder are forked from the [docker-makepkg](https://github.com/WhyNotHugo/docker-makepkg)
repo.

This container is intended to test `PKGBUILDs` by installing dependencies and
running `makepkg -f` in a clean Arch installation.

This fork builds the package with the number of cores returned by `$(nproc)`
and compresses it using ZSTD. The script `run.sh` is changed to a bash script
to avoid errors with hyphens in function names in the PKGBUILDs.

## Container setup

### Build

```sh
podman build -t makepkg:Containerfile . -f Containerfile
```

### Run

Use either of the following commands.

```
# This does not export the built package
podman run -v $PWD:/pkg makepkg:Containerfile

# This exports the built package file to the working directory
podman run -e EXPORT_PKG=1 -v $PWD:/pkg makepkg:Containerfile
```

## Extra details

* `base-devel` is preinstalled.
* All `depends` will be installed (including AUR packages using [yay](https://github.com/Jguer/yay)).
* GPG keys used to verify signatures are auto-fetched.
* Packages installed during image creation are not updated when building a package. You may want to update image if errors arise due to old packages.

## Licence

This repository is licensed under the ISC licence. See LICENCE for details.
