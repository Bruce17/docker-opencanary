# Docker image for [OpenCanary](https://github.com/thinkst/opencanary)

![CI](https://github.com/Bruce17/docker-opencanary/workflows/CI/badge.svg?branch=main)

Repository to build an [OpenCanary](https://github.com/thinkst/opencanary) container image. CI pipeline automatically builds multi arch container images and pushes them to [Docker Hub](https://hub.docker.com/r/hansdampf17/opencanary).


## Build

Trigger a build:

```
$ docker build -t sometag -f Dockerfile --build-arg VERSION=0.5.5 .
```


## Notice

OpenCanary officically is running only on top of Python v2.7, but this build uses Python v3. OpenCanary v0.5.6 only supports Python v2.7 and is not installable using Python 3. Complete Python v3 support is under development as stated on [Github](https://github.com/thinkst/opencanary).
