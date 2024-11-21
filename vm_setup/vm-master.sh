#!/usr/bin/env bash
set -e

# values inside vm-network-default.xml
# <host mac='52:54:00:d0:36:e0' name="vm-micro-os-master"  ip="192.168.122.40" />
mac='52:54:00:d0:36:e0'
name='vm-micro-os-master'

# For os-info see:
# sudo virt-install --osinfo list
osinfo='slem5.5'
memory='2048'
diskgb='40'
vcpus='2'

sudo virt-install \
  --connect qemu:///system \
  --name $name \
  --vcpus $vcpus \
  --memory $memory \
  --disk ${PWD}/vm-micro-os-master.qcow2 \
  --osinfo $osinfo \
  --os-variant $osinfo \
  --graphics vnc \
  --virt-type kvm \
  --network default,mac=$mac \
  --noautoconsole \
  --sysinfo type=fwcfg,entry0.name="opt/org.opensuse.combustion/script",entry0.file="${PWD}/combustion-master.sh" \
  --import &


# virt-viewer --connect qemu:///system --wait $base
sudo virsh list --all
