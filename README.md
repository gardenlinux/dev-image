# Garden Linux Dev Image 🐧💻

This image based on [the Garden Linux Builder](https://github.com/gardenlinux/builder) is meant for building [Garden Linux](https://gardenlinux.io/).
The Garden Linux Builder is containerized, so if your build host is running Linux you probably don't need this image.

The image supports building the Garden Linux images out of the box and contains tools to make development more comfortable.

The image supports two modes of operation:
- As a plain qemu vm
- As a lima-vm

Using lima might be desriable for its life cycle features, but is entirely optional.

The image can be used in combination with [remote development using ssh features by vs code](https://code.visualstudio.com/docs/remote/ssh).

## Raw qemu

```bash
./build base-dev-raw
./bin/start-vm .build/base-dev-raw-(arm/amd)64-trixie-*.raw
# Generate ssh key via `make-dev-ssh-key.sh`
# Put ssh key to $HOME/.gardenlinux/dev-id_rsa on your host
./bin/devssh
```

To use it with vs code remote ssh, add an entry like this to your `.ssh/config` file (be sure to replace the path of your home directory):

```
Host gl-dev
  HostName localhost
  StrictHostKeyChecking no
  IdentityFile /YOUR_HOME_DIR/.gardenlinux/dev-id_rsa
  Port 2223
  BatchMode yes
  User dev
```

## Lima-VM

Download the image using the github cli (depending on your native architecture):

```bash
gh run download --name lima-dev-image-arm64
gh run download --name lima-dev-image-amd64
```

Rename the downloaded file to `dev-(arm/amd)64.qcow2`.

Create the VM, start it, open a shell:

```bash
limactl create --name gl-dev gl-dev.yaml
limactl start gl-dev
```
