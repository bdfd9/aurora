#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

# Remove desktop entries
if [[ -f /usr/share/applications/gnome-system-monitor.desktop ]]; then
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nHidden=true@g' /usr/share/applications/gnome-system-monitor.desktop
fi
if [[ -f /usr/share/applications/org.gnome.SystemMonitor.desktop ]]; then
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nHidden=true@g' /usr/share/applications/org.gnome.SystemMonitor.desktop
fi

# Branding for Images
ln -sf ../places/distributor-logo.svg /usr/share/icons/hicolor/scalable/apps/start-here.svg
ln -sf /usr/share/wallpapers/aurora-wallpaper-1/contents/images/15392x8616.jpg /usr/share/backgrounds/default.png
ln -sf /usr/share/wallpapers/aurora-wallpaper-1/contents/images/15392x8616.jpg /usr/share/backgrounds/default-dark.png
ln -sf aurora.xml /usr/share/backgrounds/default.xml


# Test aurora gschema override for errors. If there are no errors, proceed with compiling aurora gschema, which includes setting overrides.
mkdir -p /tmp/aurora-schema-test
find /usr/share/glib-2.0/schemas/ -type f ! -name "*.gschema.override" -exec cp {} /tmp/aurora-schema-test/ \;
cp /usr/share/glib-2.0/schemas/zz0-aurora-modifications.gschema.override /tmp/aurora-schema-test/
echo "Running error test for aurora gschema override. Aborting if failed."
glib-compile-schemas --strict /tmp/aurora-schema-test
echo "Compiling gschema to include aurora setting overrides"
glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null

# Watermark for Plymouth
cp /usr/share/plymouth/themes/spinner/{"$BASE_IMAGE_NAME"-,}watermark.png

echo "::endgroup::"
