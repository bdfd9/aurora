#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

## Pins and Overrides
## Use this section to pin packages in order to avoid regressions
# Remember to leave a note with rationale/link to issue for each pin!
#
# Example:
#if [ "$FEDORA_MAJOR_VERSION" -eq "41" ]; then
#    Workaround pkcs11-provider regression, see issue #1943
#    rpm-ostree override replace https://bodhi.fedoraproject.org/updates/FEDORA-2024-dd2e9fb225
#fi

# Current aurora systems have the bling.sh and bling.fish in their default locations
mkdir -p /usr/share/ublue-os/aurora-cli
cp /usr/share/ublue-os/bling/* /usr/share/ublue-os/aurora-cli

# Copy flatpak list on image to compare against it on boot wo/ requiring curl to gh
FLATPAK_LIST=($(cat /ctx/aurora_flatpaks/flatpaks))
if [[ ${IMAGE_NAME} =~ "dx" ]]; then
    FLATPAK_LIST+=($(cat /ctx/dx_flatpaks/flatpaks))
fi
printf "%s\n" "${FLATPAK_LIST[@]}" > /usr/share/ublue-os/flatpak_list

# Try removing just docs (is it actually promblematic?)
rm -rf /usr/share/doc/just/README.*.md

echo "::endgroup::"
