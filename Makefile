VERSION ?= 0.5.6
CACHE ?= --no-cache=1
FULLVERSION ?= ${VERSION}
# archs ?= amd64 arm32v6 armhf arm64v8
archs ?= armhf

.PHONY: all build publish latest
all: build publish latest
qemu-arm-static:
	cp /usr/bin/qemu-arm-static .
qemu-aarch64-static:
	cp /usr/bin/qemu-aarch64-static .
build: qemu-arm-static qemu-aarch64-static
	$(foreach arch,$(archs), \
		docker build -t hansdampf17/opencanary:${VERSION}-$(arch) -f Dockerfile --build-arg ARCH=$${archi} ${CACHE} --build-arg VERSION=${VERSION} .;\
	)
publish:
	docker push hansdampf17/opencanary
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
