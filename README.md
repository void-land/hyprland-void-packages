## Hyprland for Void Linux

Welcome to the repository for building and installing [Hyprland](https://github.com/hyprwm/Hyprland) on Void Linux. Here, you'll find templates, binaries, and comprehensive instructions for a seamless installation experience.

### Installation

The simplest way to install Hyprland on Void Linux is by using our [repository](https://github.com/void-land/hyprland-void-packages). This repository includes binaries automatically built using GitHub Actions whenever a new commit is pushed.

#### Adding the Repository

To add this repository to xbps's repositories, create a configuration file `/etc/xbps.d/hyprland-void-repo.conf` with the following content:

```sh
echo 'repository=https://raw.githubusercontent.com/void-land/hyprland-void-packages/repository-x86_64-glibc' | sudo tee /etc/xbps.d/hyprland-void-repo.conf
```

```sh
echo 'repository=https://github.com/void-land/hyprland-void-packages/releases/latest/download/' | sudo tee /etc/xbps.d/hyprland-packages.conf
```

#### Installing Hyprland

Once the repository is added, you can install Hyprland like any other program:

```sh
sudo xbps-install -S hyprland
```

You can also search for all Hyprland-related packages:

```sh
xbps-query -Rs hypr
```

During the first use, you will need to accept the repository's fingerprint with `xbps-install -S`.

### Supported Architectures

This repository provides binary packages for:
- `x86_64-glibc`
- `x86_64-musl`

Update the URL in `/etc/xbps.d/hyprland-void.conf` to match your desired architecture.

### Nightly Builds

Nightly binary packages are available, built automatically at 00:00 UTC from the latest git commit. Templates for these builds are also provided, but you will need to manually force a rebuild each time as XBPS does not natively support automatic updates for git packages.

### Running Hyprland

To run Hyprland, you may need to install additional packages depending on your setup, such as a [session and seat manager](https://docs.voidlinux.org/config/session-management.html) and [graphics drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html). Additionally, ensure that your user is added to the `_seatd` group.

#### Note for Nvidia Users

The `hyprland-nvidia` package is no longer necessary as of [version 0.33.0](https://github.com/hyprwm/Hyprland/releases/tag/v0.33.0). While Nvidia support is still unofficial, please refer to the [manual](https://wiki.hyprland.org/hyprland-wiki/pages/Nvidia/) for more information.

### Additional Packages

This repository also includes packages for:
- hypridle
- hyprlock
- hyprpaper
- hyprlang
- hyprutils
- swayosd
- xdg-desktop-portal-hyprland

### Manually Building Hyprland

If you need to customize the build, follow these steps to manually build Hyprland:

1. **Prepare Directories**:

```sh
mkdir -p ~/repos
cd ~/repos
```

2. **Clone void-packages**:

```sh
git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
cd ..
```

3. **Clone hyprland-void-packages**:

```sh
git clone https://github.com/void-land/hyprland-void-packages.git
cd hyprland-void-packages
```

4. **Update Shared Libraries**:

```sh
cat common/shlibs >> ../void-packages/common/shlibs
```

5. **Copy Source Packages**:

```sh
cp -r srcpkgs/* ../void-packages/srcpkgs
```

6. **Build and Install**:

```sh
cd ../void-packages
./xbps-src pkg hyprland
sudo xbps-install -R hostdir/binpkgs hyprland
```

By following these instructions, you'll have Hyprland up and running on your Void Linux system in no time. For more details, refer to the official documentation and the [Hyprland GitHub page](https://github.com/hyprwm/Hyprland).