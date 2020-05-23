# LaTeX installation

The Containerfiles within this folder provide a LaTeX environment on top of

- Debian Stretch (`Containerfile.stretch`) or
- Debian Buster (`Containerfile.buster`).

The Buster installation is more up-to-date but it is about 1 GB larger in
size than the Stretch installation.

Inspired by https://hub.docker.com/r/tianon/latex/dockerfile.

## Container setup

### Build

Build either the Buster or Stretch version by replacing `version` with
`buster` or `stretch`.

```sh
podman build -t latex:version . -f Containerfile.version
```

### Run

The current way to run and test this container is to run the following command
which mounts your working directory to `/mnt` in the container. Navigate
through the container using the bash shell.

```sh
podman run -it --rm -w /mnt -v $PWD:/mnt latex:version bash
```

## VS Code LaTeX Workshop extension setup

**NOTE:** This section is a work-in-progress.

To do list

- Write a program that finds all of the source files included in a LaTeX file
  that are outside of the working directory

Help: https://github.com/James-Yu/LaTeX-Workshop/wiki/Install#using-docker
