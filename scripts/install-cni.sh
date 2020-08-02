#!/bin/sh
set -eu;

# Install Flannel CNI binary on Kubernetes host
#
# Mounts:
# Host CNI bin dir mounted at /host/opt/cni/bin
# Host CNI conf dir mounted at /host/etc/cni/net.d
#
# Variables:
# CNI_CONF_NAME - CNI config filename
# CNI_NETWORK_CONFIG - CNI configuration

CNI_BIN_DIR=${CNI_BIN_DIR:-/opt/cni/bin}

if [ -w "/host/${CNI_BIN_DIR}" ]; then
  echo "Writing CNI binaries to host ${CNI_BIN_DIR}"
  cp /opt/cni/bin/* /host/${CNI_BIN_DIR};
  echo "Wrote CNI binaries to host ${CNI_BIN_DIR}"
else
  echo "Skip writing CNI binaries"
fi;

CNI_CONF_NAME=${CNI_CONF_NAME:-10-flannel.conflist}
CNI_NET_DIR=${CNI_NET_DIR:-/etc/cni/net.d}

if [ -w "/host/${CNI_NET_DIR}" ]; then
  echo "Writing CNI config to host ${CNI_NET_DIR}"
  TMP_CONF='/flannel.conflist.default'
  cat >$TMP_CONF <<EOF
${CNI_NETWORK_CONFIG}
EOF
  mv $TMP_CONF /host/${CNI_NET_DIR}/${CNI_CONF_NAME}
  echo "Wrote CNI config: $(cat /host/${CNI_NET_DIR}/${CNI_CONF_NAME})"
else
  echo "Skip writing CNI config"
fi;

