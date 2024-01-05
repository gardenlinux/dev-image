# Garden Linux Dev Image 🐧💻

This image based on [the Garden Linux Builder](https://github.com/gardenlinux/builder) is meant for building [Garden Linux](https://gardenlinux.io/).
The Garden Linux Builder is containerized, so if your build host is running Linux you probably don't need this image.
You may still want to use the image as it provides a ready-to-use environment for working with Garden Linux.
It's purpose is to make it more convenient to build and develop Garden Linux and related projects.

The image supports two modes of operation:
- As a raw qemu vm
- As a [lima-vm](https://lima-vm.io/)

Using lima might be desriable for its life cycle features, but is entirely optional.

The image can be used in combination with [remote development using ssh features by vs code](https://code.visualstudio.com/docs/remote/ssh).

## Building the image

The image can be built in two variants.

To build the qemu variant, run this command:

```
./build base-dev-raw
```

To build the lima-vm variant, run this command:

```
./build base-dev-lima
```

## Downloading pre-built images

Images are built on GitHub Actions and can be downloaded using the `gh` cli tool.

Download the raw image, depending on architecture:

```bash
gh run download --name dev-image-amd64
```

```bash
gh run download --name dev-image-arm64
```

Download the lima-vm image, depending on architecture:

```bash
gh run download --name lima-dev-image-amd64
```

```bash
gh run download --name lima-dev-image-arm64
```

## Runing the virtual machine

To run the virtual machine, either build the image or download a pre-built image.
Be sure to pick the variant that's suitable for your use-case.

### Raw qemu

This method makes use of the `start-vm` script that's part of this GitHub repo.
Using this method you will be logged in using the `dev` user and you can make use of `sudo` without providing a password.

It's not recommended to work in this shell as the serial console is less reliable than a ssh session.

Both the `dev` user and the `root` user don't have a password.
After starting the virtual machine, create a ssh key using the `make-dev-ssh-key.sh` script.

```bash
git clone https://github.com/gardenlinux/dev-image
dev-image/bin/start-vm path-to/base-dev-raw-(arm/amd)64-trixie-*.raw
# Generate ssh key via `make-dev-ssh-key.sh`
# Put ssh key to $HOME/.gardenlinux/dev-id_rsa on your host
dev-image/bin/devssh
```

This provides a ssh login to the virtual machine.

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

Now you can connect to the `gl-dev` host and work like you would on your local workstation.

### Lima-VM

Create a `gl-dev.yaml` manifest file based on this template:

```yaml
images:
- location: "./path-to/dev-image.qcow2"

vmType: qemu
os: Linux
memory: 8GiB
containerd:
  system: false
  user: false
```

Create and start the virtual machine:

```bash
limactl create --name gl-dev gl-dev.yaml
echo "Include ${LIMA_HOME:-$HOME/.lima}/gl-dev/ssh.config" >> ~/.ssh/config
limactl start gl-dev
limactl shell gl-dev
```

Connect to host 'lima-gl-dev' in VS Code via the SSH Remote plugin

## Required configuration in the virtual machine

- Perform the required git configuration to be able to commit and push code
    - Configure your name and email
    - Configure a [GitHub personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
