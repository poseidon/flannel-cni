# flannel-cni
[![Quay](https://img.shields.io/badge/container-quay-green)](https://quay.io/repository/poseidon/flannel-cni)
[![Sponsors](https://img.shields.io/github/sponsors/poseidon?logo=github)](https://github.com/sponsors/poseidon)
[![Mastodon](https://img.shields.io/badge/follow-news-6364ff?logo=mastodon)](https://fosstodon.org/@poseidon)

`flannel-cni` provides a container image that installs a CNI config and CNI binaries on Kubernetes nodes. Ideal for container-optimized OSes like Fedora CoreOS and Flatcar Linux.

* Install `CNI_NETWORK_CONFIG` to `/etc/cni/net.d`
* Install CNI plugin binaries to `/opt/cni/bin`

## Usage

Add `flannel-cni` as an init container to a [flannel](https://github.com/coreos/flannel) DaemonSet. See [Typhoon](https://github.com/poseidon/terraform-render-bootstrap/tree/master/resources/flannel) for an active example.

```yaml
initContainers:
  - name: install-cni
    image: quay.io/poseidon/flannel-cni:v0.4.2
    command: ["/install-cni.sh"]
    env:
      - name: CNI_NETWORK_CONFIG
        valueFrom:
          configMapKeyRef:
            name: flannel-config
            key: cni-conf.json
    volumeMounts:
      - name: cni-bin-dir
        mountPath: /host/opt/cni/bin/
      - name: cni-conf-dir
        mountPath: /host/etc/cni/net.d
containers:
  ...
volumes:
  ...
  # Used by install-cni
  - name: cni-bin-dir
    hostPath:
      path: /opt/cni/bin
  - name: cni-conf-dir
    hostPath:
      path: /etc/kubernetes/cni/net.d
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: flannel-config
  namespace: kube-system
  labels:
    tier: node
    k8s-app: flannel
data:
  cni-conf.json: |
    {
      "name": "cbr0",
      "cniVersion": "0.3.1",
      "plugins": [
        {
          "type": "flannel",
          "delegate": {
            "hairpinMode": true,
            "isDefaultGateway": true
          }
        },
        {
          "type": "portmap",
          "capabilities": {
            "portMappings": true
          }
        }
      ]
    }
```

## Publish

Container images are published according to [Typhoon policy](https://typhoon.psdn.io/topics/security/#container-images).

* [quay.io/poseidon/flannel-cni](https://quay.io/repository/poseidon/flannel-cni) (official)

