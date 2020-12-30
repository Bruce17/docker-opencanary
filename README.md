# Docker image for [OpenCanary](https://github.com/thinkst/opencanary)

<p align="center">
  <a href="https://github.com/bruce17/ghaction-package-latest-version/releases/latest"><img alt="package-latest-version release" src="https://img.shields.io/github/release/bruce17/ghaction-package-latest-version.svg?style=flat"></a>
  <a href="https://github.com/Bruce17/docker-opencanary/actions?query=workflow%3A%22build+images%22"><img alt="GitHub Workflow Status (branch)" src="https://img.shields.io/github/workflow/status/Bruce17/docker-opencanary/build%20images/main?label=build%20images&logo=github"></a>
  <a href="https://github.com/Bruce17/docker-opencanary/actions?query=workflow%3A%22check+python+package%22"><img alt="GitHub Workflow Status (branch)" src="https://img.shields.io/github/workflow/status/Bruce17/docker-opencanary/check%20python%20package/main?label=check%20package%20status&logo=github"></a>
</p>

Repository to build an [OpenCanary](https://github.com/thinkst/opencanary) container image. [CI pipeline](https://github.com/Bruce17/docker-opencanary/actions) automatically builds multi arch container images and pushes them to [Docker Hub](https://hub.docker.com/r/hansdampf17/opencanary).


## Build

Trigger a build:

```
$ docker build -t sometag -f Dockerfile --build-arg VERSION=0.5.5 .
```


## Notice

OpenCanary officically is running only on top of Python v2.7, but this build uses Python v3. OpenCanary v0.5.6 only supports Python v2.7 and is not installable using Python 3. Complete Python v3 support is under development as stated on [Github](https://github.com/thinkst/opencanary).
