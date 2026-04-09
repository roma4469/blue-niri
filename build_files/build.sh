#!/bin/bash
set -ouex pipefail

# cleanup old repo dust
rm -f /etc/yum.repos.d/_copr_ublues-os-akmods.repo
rm -f /etc/yum.repos.d/_copr_avengemedia-dms.repo

dnf5 -y copr enable ublue-os/akmods
# dnf5 -y copr enable avengemedia/dms

### Install packages
# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 install -y \
	niri \
	greetd \
	dbus-daemon \
	tuigreet \
	kitty \
	fish \
	waybar \
	mako \
	fuzzel \
	xwayland-satellite \
	swaybg \
	wl-clipboard \
	yazi \
	mc 
#    dms \
#    dms-greeter \
#    cliphist

install -Dm644 /ctx/files/etc/greetd/config.toml /etc/greetd/config.toml
install -Dm644 /ctx/files/etc/niri/config.kdl /etc/niri/config.kdl
install -Dm644 /ctx/files/etc/skel/.config/niri/config.kdl /etc/skel/.config/niri/config.kdl
install -Dm644 /ctx/files/etc/skel/.config/waybar/config.jsonc /etc/skel/.config/waybar/config.jsonc
install -Dm644 /ctx/files/etc/skel/.config/waybar/style.css /etc/skel/.config/waybar/style.css

dnf5 -y copr disable ublue-os/akmods
# dnf5 -y copr disable avengemedia/dms

systemctl enable podman.socket
systemctl enable greetd.service
systemctl disable gdm.service || true
systemctl set-default graphical.target

# cleanup
rm -rf /run/dnf /run/selinux-policy /tmp/*
