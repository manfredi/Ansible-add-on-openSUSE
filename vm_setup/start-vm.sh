#!/usr/bin/env bash
set -e

# Create network
# Try to destroy and ignore errors
! sudo virsh net-destroy default

# Create default network
sudo virsh net-create vm-network-default.xml

# check
sudo virsh net-list --all

# start vm
sudo virsh start vm-micro-os-master
sudo virsh start vm-micro-os-slave-1
sudo virsh start vm-micro-os-slave-2
sudo virsh start vm-micro-os-slave-3
sudo virsh start vm-micro-os-slave-4
sudo virsh start vm-micro-os-slave-5
sudo virsh start vm-micro-os-slave-6

# check
sudo virsh list --all
