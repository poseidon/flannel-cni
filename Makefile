VERSION=$(shell git describe --tags --match=v* --always --dirty)
CNI_VERSION=v0.9.1

LOCAL_REPO?=poseidon/flannel-cni
IMAGE_REPO?=quay.io/poseidon/flannel-cni

image: \
	image-amd64 \
	image-arm64

image-%:
	buildah bud -f Dockerfile \
		-t $(LOCAL_REPO):$(VERSION)-$* \
		--arch $* --override-arch $* \
		--build-arg ARCH=$* \
		--build-arg CNI_VERSION=$(CNI_VERSION) \
		--format=docker .

