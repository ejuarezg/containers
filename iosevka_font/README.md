# Build environment for Iosevka font

## Introduction

One of my favorite monospace fonts is
[Iosevka](https://github.com/be5invis/Iosevka). A containarized build
environment will ensure that you have all of the correct build tools installed
without cluttering your system. This guide provides instructions on how to build
the Iosevka font in a Docker or podman container. **The container targets font
versions 3.0.0 or higher.**

## Set up build environment

This section walks you through the creation of a container with the Iosevka font
build environment.

Assuming you have Docker or podman installed on your computer, change into the
folder containing this repo's Dockerfile and run
```sh
# Using docker
docker build [optional build args] -t  iosevka_build . -f Dockerfile

# Using podman
podman build --format docker [optional build args] -t iosevka_build . -f Dockerfile
```

**Note:** Do not include `[optional build args]` when building the actual
container unless you know exactly what build arguments you want to use. For a
list of build arguments, search for the `ARG` lines in the Dockerfiles. The
build arguments are only used to download specific versions of the build
tools.

## Build process

For further instructions of the build process, you can refer to the [*Build Your
Own Style*](https://github.com/be5invis/Iosevka#build-your-own-style) section in
the Iosevka repo README.

1. Create a build plan by copying the sample plan in the Iosevka font repo and
   editing it.
1. Place the build plan in a subfolder called, for example, `build_dir`.
1. Build the font with the command (replace docker with podman if necessary)
    ```sh
    docker run -it -v ./build_dir:/build iosevka_build [optional build args]
    ```
    Use the environment variable `FONT_VERSION` to specify the font version
    that you want to build. Otherwise the latest font version is built. You
    can also specify custom build arguments mentioned in *Build Your Own
    Style*. For example, to only build the TTF files of version 3.0.1, we
    would run
    ```sh
    docker run -it -e FONT_VERSION=3.0.1 -v ./build_dir:/build iosevka_build ttf::iosevka-custom
    ```
    **Notes:**
    - If no custom build arguments are provided, the first build plan in
      `private-build-plans.toml` is used. Otherwise, you must specify
      everything you would normally put after `npm run build--`.
    - Use `FONT_VERSION=dev` to build the bleeding edge code from the dev
      branch.
    - The `-it` option is used so that you can cancel the build by pressing `Ctrl+c` with your keyboard.
    - The container is not removed automatically so that you can debug the
      container.
1. Once the font files are built, they will be placed in a folder called
   `dist` inside `build_dir`.

### Try out the fonts

Copy the subfolders inside `dist` to `~/.local/share/fonts` and run `fc-cache`

## Helpful links

- https://github.com/be5invis/Iosevka
- [Original Dockerfile](https://gist.github.com/tasuten/0431d8af3e7b5ad5bc5347ce2d7045d7)
- https://github.com/nodesource/distributions/blob/master/README.md
- https://premake.github.io/download.html#v5
- https://stackoverflow.com/questions/6482377/check-existence-of-input-argument-in-a-bash-shell-script
- https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
- https://stackoverflow.com/questions/1247812/how-to-use-grep-to-get-anything-just-after-name

## My font style

My last build uses the build plan in
[private-build-plans.toml](./private-build-plans.toml).
