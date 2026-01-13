#!/bin/bash
set -e

echo "=== Step 1: Creating NVIDIA Xorg config ==="
sudo tee /etc/X11/xorg.conf.d/10-nvidia.conf > /dev/null << 'EOF'
Section "Device"
    Identifier     "Nvidia Card"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    Option         "NoLogo" "true"
EndSection
EOF
echo "Created /etc/X11/xorg.conf.d/10-nvidia.conf"

echo "=== Step 2: Blacklisting nouveau driver ==="
sudo tee /etc/modprobe.d/nvidia.conf > /dev/null << 'EOF'
blacklist nouveau
options nvidia_drm modeset=1
EOF
echo "Created /etc/modprobe.d/nvidia.conf"

echo "=== Step 3: Adding NVIDIA modules to mkinitcpio ==="
sudo sed -i 's/^MODULES=(btrfs)/MODULES=(btrfs nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
echo "Updated /etc/mkinitcpio.conf"

echo "=== Step 4: Regenerating initramfs ==="
sudo mkinitcpio -P

echo "=== Done! ==="
echo "Please reboot your system now with: sudo reboot"
