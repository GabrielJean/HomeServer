USB Zigbee Dongle + Docker Compose Recovery Guide

Context
- Host OS: Ubuntu (Home Assistant host)
- Container: ghcr.io/home-assistant/home-assistant:stable
- Device: Silicon Labs CP210x (Sonoff Zigbee 3.0 USB Dongle Plus V2)
- Stable device alias: /dev/ttyUSB-zigbee (via udev rule)
- Compose uses: /dev/ttyUSB-zigbee:/dev/ttyUSB0

Common Symptom
- docker compose up fails with an error like:
  Error response from daemon: error gathering device information while adding custom device "/dev/serial/by-id/...": no such file or directory
- And no /dev/ttyUSB* or /dev/serial/by-id entries exist after replug/reboot.

Quick Fix Checklist
1) Confirm the USB device is seen by the OS
   - lsusb | grep -i "cp210\|silicon\|sonoff\|itead"
2) Ensure kernel modules are present (after kernel updates)
   - uname -r
   - dpkg -l | grep "linux-modules-extra-$(uname -r)"
   - If missing, install: sudo apt-get update && sudo apt-get install -y "linux-modules-extra-$(uname -r)"
3) Load or verify drivers are loaded
   - sudo modprobe cp210x
   - lsmod | egrep "cp210x|usbserial"
4) Verify device nodes
   - ls -l /dev/serial/by-id || true
   - ls -l /dev/ttyUSB* || true
   - Expected: /dev/ttyUSB0 and a by-id link. Also /dev/ttyUSB-zigbee should exist.
5) Bring up Docker Compose
   - docker compose up -d
   - Check status: docker compose ps --all
   - Logs (if needed): docker compose logs --no-log-prefix --tail=200 homeassistant

Permanent Improvements Already in Place
- Persistent udev rule creates /dev/ttyUSB-zigbee for the dongle:
  File: /etc/udev/rules.d/99-zigbee.rules
  Rule:
  KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", SYMLINK+="ttyUSB-zigbee", GROUP="dialout", MODE="0660"
- Auto-load drivers at boot:
  File: /etc/modules-load.d/zigbee.conf
  Contents:
  cp210x
  usbserial
- Docker Compose uses the stable alias:
  devices:
    - /dev/ttyUSB-zigbee:/dev/ttyUSB0

If It Breaks Again After a Kernel Update
- Ensure the extra modules for the running kernel are installed:
  sudo apt-get update && sudo apt-get install -y "linux-modules-extra-$(uname -r)"
- Re-load modules (or just reboot):
  sudo modprobe cp210x
- Replug the USB dongle.

VM/Hypervisor Note
- If running in a VM and lsusb does NOT show the CP210x device, pass the USB device through to the VM/host again (hypervisor UI) and replug.

Permissions
- The device node is owned by root:dialout. Ensure your user is in the dialout group if you need direct access:
  groups
  sudo usermod -aG dialout "$USER"  # then re-login or run: newgrp dialout

Verification Commands
- Check the symlink exists and points to the active port:
  ls -l /dev/ttyUSB-zigbee /dev/serial/by-id
- Confirm Home Assistant container is healthy:
  docker compose ps --all
  docker compose logs --no-log-prefix --tail=200 homeassistant

Advanced: Bind to this exact dongle only
- You can refine the udev rule to match the device serial for this specific stick:
  Get serial:
    udevadm info -a -n /dev/ttyUSB0 | grep -m1 'ATTRS{serial}'
  Example serial: 9a520d8a0274ef118d78e71e313510fd
  Rule variant (replace serial value accordingly):
  KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", ATTRS{serial}=="9a520d8a0274ef118d78e71e313510fd", SYMLINK+="ttyUSB-zigbee", GROUP="dialout", MODE="0660"
  Then reload and trigger:
    sudo udevadm control --reload && sudo udevadm trigger

One-liners to Re-apply Core Fixes
- Install kernel extras for current kernel:
  sudo apt-get update && sudo apt-get install -y "linux-modules-extra-$(uname -r)"
- Ensure modules auto-load:
  printf "%s\n" cp210x usbserial | sudo tee /etc/modules-load.d/zigbee.conf
- Recreate udev rule (if ever needed):
  printf '%s\n' 'KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", SYMLINK+="ttyUSB-zigbee", GROUP="dialout", MODE="0660"' | sudo tee /etc/udev/rules.d/99-zigbee.rules
  sudo udevadm control --reload && sudo udevadm trigger

That’s it—this should get Home Assistant back up quickly whenever the USB dongle is replugged or after a reboot/kernel update.

