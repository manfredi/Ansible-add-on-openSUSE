#!/usr/bin/env bash
set -e

# Try to destroy and ignore errors
! sudo virsh net-destroy default

# Create default network
sudo virsh net-create vm-network-default.xml

sudo virsh net-list --all

memory='2048'
diskgb='40'
vcpus='2'

####################
# openSUSE-MicroOS #
####################

osinfo='slem5.5'

# values inside vm-network-default.xml
# <host mac='52:54:00:d0:36:e1' name="vm-micro-os-slave-1" ip="192.168.122.41" />
# <host mac='52:54:00:d0:36:e2' name="vm-micro-os-slave-2" ip="192.168.122.42" />
# <host mac='52:54:00:d0:36:e3' name="vm-micro-os-slave-3" ip="192.168.122.43" />
# <host mac='52:54:00:d0:36:e4' name="vm-micro-os-slave-4" ip="192.168.122.44" />
# <host mac='52:54:00:d0:36:e5' name="vm-micro-os-slave-5" ip="192.168.122.45" />
# <host mac='52:54:00:d0:36:e6' name="vm-micro-os-slave-6" ip="192.168.122.46" />


for i in {1..6}
do
sudo virt-install \
  --connect qemu:///system \
  --name vm-micro-os-slave-${i} \
  --vcpus $vcpus \
  --memory $memory \
  --disk ${PWD}/vm-micro-os-slave-${i}.qcow2 \
  --osinfo $osinfo \
  --os-variant $osinfo \
  --graphics vnc \
  --virt-type kvm \
  --network default,mac=52:54:00:d0:36:e${i} \
  --noautoconsole \
  --sysinfo type=fwcfg,entry0.name="opt/org.opensuse.combustion/script",entry0.file="${PWD}/combustion-slave.sh" \
  --import &
done

#  --sysinfo type=fwcfg,entry0.name="opt/com.coreos/config",entry0.file="${PWD}/ignition.json" \
#  --sysinfo type=fwcfg,entry0.name="opt/org.opensuse.combustion/script",entry0.file="${PWD}/combustion.sh" \

sudo virsh list --all
