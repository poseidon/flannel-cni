FROM docker.io/alpine:3.23.3 AS builder
ARG ARCH
ARG CNI_VERSION
COPY scripts /scripts
RUN /scripts/fetch-cni.sh

FROM docker.io/alpine:3.23.3
LABEL maintainer="Dalton Hubble <dghubble@gmail.com>"
LABEL org.opencontainers.image.title="flannel-cni",
LABEL org.opencontainers.image.source="https://github.com/poseidon/flannel-cni"
LABEL org.opencontainers.image.vendor="Poseidon Labs"
COPY --from=builder /bin/loopback /opt/cni/bin/loopback
COPY --from=builder /bin/bridge /opt/cni/bin/bridge
COPY --from=builder /bin/host-local /opt/cni/bin/host-local
COPY --from=builder /bin/portmap /opt/cni/bin/portmap
COPY --from=builder /bin/bandwidth /opt/cni/bin/bandwidth
COPY scripts/install-cni.sh /install-cni.sh
