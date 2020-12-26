# Docker image for [OpenCanary](https://github.com/thinkst/opencanary)

![CI](https://github.com/Bruce17/docker-opencanary/workflows/CI/badge.svg?branch=main)


## Build

Trigger a build:

```
$ docker build -t sometag -f Dockerfile --build-arg VERSION=0.5.6 .
```

Build multi arch (e.g. in CI):

```
make build
```
