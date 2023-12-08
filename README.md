# Garden Linux Dev Image

Download the image using the github cli (depending on your native architecture):

```
gh run download --name dev-image-arm64
gh run download --name dev-image-amd64
```

Rename the downloaded file to `dev-(arm/amd)64.qcow2`.

Create the VM, start it, open a shell:

```
limactl create --name gl-dev gl-dev.yaml
limactl start gl-dev
limactl start gl-dev
```
