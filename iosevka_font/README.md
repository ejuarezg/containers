# Build environment for Iosevka font

## Introduction

One of my favorite monospace fonts is
[Iosevka](https://github.com/be5invis/Iosevka). Using a containarized build
environment, we can make the process of building a custom style almost
painless.

These instructions apply to font versions 3.0.0 or higher and target a
Linux-based OS.

## Set up build environment

The build environment can be setup one of two different ways. The first is to
download all the build tools onto your computer manually or using a package
manager (we call this the *manual method*). Alternatively, you can create a
container with the build environment.

### Manual method

1. Install the dependencies mentioned in the [*Building from
   Source*](https://github.com/be5invis/Iosevka#building-from-source) section.
2. Download the source code by running
    ```sh
    VERSION=3.0.1
    curl -L -O --proto '=https' --tlsv1.2 https://github.com/be5invis/Iosevka/archive/v${VERSION}.tar.gz
    tar -xf v${VERSION}.tar.gz
    cd Iosevka-${VERSION}
    ```
3. Skip to **Build process** section of this file.

### Container method

Assuming you have Docker or podman installed on your computer, to create a
containarized build environment, change into the folder of the Dockerfiles and
run
```sh
# Using podman
podman build --format docker [optional build args] -t iosevka_build . -f Dockerfile

# Using docker
docker build [optional build args] -t  iosevka_build . -f Dockerfile
```

*NOTE:* Do not include `[optional build args]` when building the actual
container unless you know exactly what build arguments you want to use. For a
list of build arguments, search for the `ARG` lines in the Dockerfiles. The
build arguments are only used to download specific versions of the build
tools.

## Build process

For the build process, we will be following the [*Build Your Own
Style*](https://github.com/be5invis/Iosevka#build-your-own-style) section in
the repo readme.

### Manual method

1. For steps 1 and 2 in *Build Your Own Style*, simply copy the sample build
   plan in the source code folder with
    ```
    cp private-build-plans.sample.toml private-build-plans.toml
    ```
   and edit the file.

### Container method

1. Create a build plan by copying the sample plan in the font repo and editing
   it.
1. Place a copy of the build plan in a subfolder called, for example,
   `build_dir`.
1. Build the font with the command (replace podman with docker if necessary)
    ```sh
    podman run -v ./build_dir:/build iosevka_build
    ```
    Use the environment variable `FONT_VERSION` to specify the font version
    that you want to build. Otherwise the latest font version is built. You
    can also specify custom build arguments mentioned in *Build Your Own
    Style*. For example, to only build the TTF files of version 3.0.1, we
    would run
    ```sh
    podman run -e FONT_VERSION=3.0.1 -v ./build_dir:/build iosevka_build ttf::iosevka-custom
    ```
    *NOTE:* If no custom build arguments are provided, the first build plan in
    `private-build-plans.toml` is used. If you provide custom build arguments,
    you must specify everything you would normally put after `npm run build
    --`
1. Once the font files are built, they will be placed in a folder called
   `dist` inside `build_dir`.

### Try out the fonts

Copy the font files inside `dist` to `~/.local/share/fonts` and run `fc-cache`

## Helpful links

- https://github.com/be5invis/Iosevka
- [Inspiration for Dockerfile](https://gist.github.com/tasuten/0431d8af3e7b5ad5bc5347ce2d7045d7)
- https://github.com/nodesource/distributions/blob/master/README.md
- https://premake.github.io/download.html#v5
- https://stackoverflow.com/questions/6482377/check-existence-of-input-argument-in-a-bash-shell-script
- https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
- https://stackoverflow.com/questions/1247812/how-to-use-grep-to-get-anything-just-after-name

## My font style

I based my custom style off the Ubuntu Mono style. I used `variants.toml` in
the source code to see the differences between styles. I also consulted the
font repo readme to see what variants are enabled by default.

My last build only changes lines 2-3 in `private-build-plans.sample.toml`. The
modified lines are

```toml
family = "Miosevka"
design = ['sp-fixed', 'v-at-threefold', 'v-a-doublestorey', 'v-f-straight', 'v-i-italic', 'v-l-italic', 'v-m-shortleg', 'v-y-straight', 'v-brace-straight', 'v-one-base-serif', 'v-numbersign-slanted']
```
