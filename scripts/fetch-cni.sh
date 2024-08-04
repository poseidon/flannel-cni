#!/usr/bin/env sh
# Fetch CNI plugin binaries https://github.com/containernetworking/plugins
# Requires ARCH and CNI_VERSION
set -ex

# install dependencies
apk --no-cache add curl

echo "Download CNI plugins ${CNI_VERSION} for ${ARCH}"
curl -sSfL https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz | tar -xz -C bin/ ./loopback ./bridge ./host-local ./portmap ./tuning ./bandwidth

