## Hyprland for Void Linux

Welcome to the repository for building and installing [Hyprland](https://github.com/hyprwm/Hyprland) on Void Linux. Here, you'll find templates, binaries, and comprehensive instructions for a seamless installation experience.

### Packages

This repository provides Void Linux packages, including:
- aquamarine
- hyprland
- hyprland-protocols
- hyprlang
- hyprcursor
- hypridle
- hyprlock
- hyprpaper
- hyprutils
- swayosd
- rofi-wayland
- xdg-desktop-portal-hyprland

### Installation

The simplest way to install Hyprland on Void Linux is by using our [repository](https://github.com/void-land/hyprland-void-packages). This repository includes binaries automatically built using GitHub Actions.

#### Adding the Repository

To add this repository to xbps's repositories, create a configuration file `/etc/xbps.d/hyprland-void-repo.conf` with the following content:

```sh
echo 'repository=https://github.com/void-land/hyprland-void-packages/releases/latest/download/' | sudo tee /etc/xbps.d/hyprland-packages.conf
```

#### Installing Hyprland

Once the repository is added, you can install Hyprland like any other program:

```sh
sudo xbps-install -S
```

```sh
sudo xbps-install -Sy hyprland hyprland-devel aquamarine hyprcursor hypridle hyprland-protocols hyprlang hyprlock hyprpaper hyprutils hyprwayland-scanner xdg-desktop-portal-hyprland
```

You can also search for all Hyprland-related packages:

```sh
xbps-query -Rs hypr
```

### Running Hyprland

To run Hyprland, you may need to install additional packages depending on your setup, such as a [session and seat manager](https://docs.voidlinux.org/config/session-management.html) and [graphics drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html). Additionally, ensure that your user is added to the `_seatd` group.

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
git clone https://github.com/void-land/hyprland-void-packages.git --depth 1
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