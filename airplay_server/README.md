# Airplay server

This airplay server is a containerized version of the tcp-forwarder example
from the [java-airplay-server-examples](https://github.com/serezhka/java-airplay-server-examples)
repo.

## Container setup

The following commands use the podman container tool. If using docker, you may
need to modify the Containerfiles.

### Build

**NOTE:** Before building image, you may wish to change the name of the
airplay server by changing `QuackPlay` to something else in the line using
`sed` in the Containerfile.

The multistage Containerfile is recommended due to its smaller size. Build the
image with

```sh
podman build -t airserver:1.0 . -f Containerfile.multi
```

### Run

To run container, use

```sh
podman run --rm --network host --name airserver -d airserver:1.0
```

## Connect to TCP stream

After starting the container, connect to the TCP stream by using either of the
following commands.

```sh
# Run this (seems to be faster than ffplay)
gst-launch-1.0 -v tcpclientsrc port=5002 ! h264parse ! avdec_h264 ! autovideosink

# or this
ffplay -f h264 -codec:v h264 -i tcp://localhost:5002 -v debug
```

## Bugs

- Cannot reconnect to stream after disconnecting (upstream bug).

## Help links

- https://spring.io/guides/gs/spring-boot-docker/#scratch
- https://www.cloudreach.com/en/resources/blog/ct-dockerizer-java/
- https://docs.docker.com/engine/reference/builder/#expose
- https://stackoverflow.com/questions/59999424/spring-boot-gradle-project-in-docker-with-continuous-build
- https://docs.docker.com/network/network-tutorial-host/
