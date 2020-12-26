VERSION ?= 0.5.6
CACHE ?= --no-cache=1
FULLVERSION ?= ${VERSION}
REPOSITORY ?= undef
archs ?= amd64 arm32v6 armhf arm64v8

.PHONY: all build publish latest
all: build publish latest
qemu-arm-static:
	cp /usr/bin/qemu-arm-static .
qemu-aarch64-static:
	cp /usr/bin/qemu-aarch64-static .
build: qemu-arm-static qemu-aarch64-static
	$(foreach arch,$(archs), \
		if [ $(arch) = amd64 ]; \
			then archi=$(arch); \
		elif [ $(arch) = arm32v6 ]; \
			then archi=armel; \
		elif [ $(arch) = armhf ]; \
			then archi=$(arch); \
		else \
			archi=arm64; \
		fi; \
		docker build -t ${REPOSITORY}:${VERSION}-$(arch) -f Dockerfile --build-arg ARCH=$${archi} ${CACHE} --build-arg VERSION=${VERSION} .;\
	)
publish:
	docker push $(REPOSITORY)
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	cat manifest2.yaml | sed "s/\$$REPOSITORY/${REPOSITORY}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
