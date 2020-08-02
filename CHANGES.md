# flannel-cni

Notable changes between versions

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
