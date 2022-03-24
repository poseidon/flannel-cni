FROM docker.io/alpine:3.15.2 AS builder
ARG ARCH
ARG CNI_VERSION
COPY scripts /scripts
RUN /scripts/fetch-cni.sh

FROM docker.io/alpine:3.15.2
LABEL maintainer="Dalton Hubble <dghubble@gmail.com>"
COPY --from=builder /bin/flannel /opt/cni/bin/flannel
COPY --from=builder /bin/loopback /opt/cni/bin/loopback
COPY --from=builder /bin/bridge /opt/cni/bin/bridge
COPY --from=builder /bin/host-local /opt/cni/bin/host-local
COPY --from=builder /bin/portmap /opt/cni/bin/portmap
COPY --from=builder /bin/bandwidth /opt/cni/bin/bandwidth
COPY scripts/install-cni.sh /install-cni.sh
