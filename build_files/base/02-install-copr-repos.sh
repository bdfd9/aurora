#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

# Add Staging repo
dnf5 -y copr enable ublue-os/staging

# Add Packages repo
dnf5 -y copr enable ublue-os/packages

# Enable repo for scx-scheds
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons

# Enable scrcpy repo
dnf5 -y copr enable zeno/scrcpy

# Enable obs-vkcapture repo
dnf5 -y copr enable kylegospo/obs-vkcapture

# Enable nerd-fonts repo
dnf5 -y copr enable che/nerd-fonts

# Podman-bootc
dnf5 -y copr enable gmaglione/podman-bootc

dnf5 -y copr enable atim/starship

if [[ "${IMAGE_NAME}" == "aurora-yoga" ]]; then
  echo "Adding yoga specific coprs..."
  dnf5 -y copr enable danayer/linux-firmware-git
  dnf5 -y update --refresh
  dnf5 -y copr enable danayer/mesa-git
  dnf5 -y update --refresh
fi

# Enable sunshine repo
dnf5 -y copr enable lizardbyte/beta

echo "::endgroup::"
