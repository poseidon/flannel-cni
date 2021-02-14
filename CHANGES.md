# flannel-cni

Notable changes between versions

## Latest

## v0.4.2

* Update CNI plugins from v0.8.7 to v0.9.1 ([#4](https://github.com/poseidon/flannel-cni/pull/4), [#5](https://github.com/poseidon/flannel-cni/pull/5))

## v0.4.1

* Update CNI plugins from v0.8.6 to v0.8.7 ([#3](https://github.com/poseidon/flannel-cni/pull/3))

## v0.4.0

* Update CNI plugins from v0.6.0 to v0.8.6
* Remove sleep to favor init container usage
* Remove default CNI config to reduce scope

### Infra

* Rewrite [coreos/flannel-cni](https://github.com/coreos/flannel-cni) as [poseidon/flannel-cni](https://github.com/poseidon/flannel-cni)
* Use Makefile and buildah for image builds
* Use multi-stage to fetch binaries separately
* Add Linux ARM64 image builds
* Publish multi-arch images to `quay.io/poseidon/flannel-cni`

## Earlier

Earlier releases can be found at [github.com/coreos/flannel-cni](https://github.com/coreos/flannel-cni/releases).
