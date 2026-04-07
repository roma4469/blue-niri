#!/bin/bash

set -ouex pipefail

# Cleanup any stale old-format repo files for prior layers/base images
rm -f /etc/yum.repos.d/_copr_ublues-os-akmods.repo
rm -f /etc/yum.repos.d/_copr_avengemedia-dms.repo

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Enable COPRs
# dnf5 -y copr enable ublue-os/akmods
dnf5 -y copr enable avengemedia/dms

# Install packages
dnf5 install -y niri \
	kitty \
	fish \
	dms \
	dms-greeter \
	cliphist \

# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/akmods
dnf5 -y copr disable avengemedia/dms

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable greetd.service
systemctl disable gdm.service || true
systemctl enable getty@tty1.service