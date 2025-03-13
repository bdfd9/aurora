#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

# Add Staging repo
dnf5 -y copr enable ublue-os/staging

# Add Packages repo
dnf5 -y copr enable ublue-os/packages

# Enable repo for scx-scheds
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons

# Enable fw-fanctrl repo
dnf5 -y copr enable tulilirockz/fw-fanctrl

# Enable scrcpy repo
dnf5 -y copr enable zeno/scrcpy

# Enable obs-vkcapture repo
dnf5 -y copr enable kylegospo/obs-vkcapture

# Enable nerd-fonts repo
dnf5 -y copr enable che/nerd-fonts


echo "::endgroup::"
