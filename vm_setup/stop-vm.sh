#!/usr/bin/env bash
set -e

# shutdown
sudo virsh shutdown vm-micro-os-master
sudo virsh shutdown vm-micro-os-slave-1
sudo virsh shutdown vm-micro-os-slave-2
sudo virsh shutdown vm-micro-os-slave-3
sudo virsh shutdown vm-micro-os-slave-4
sudo virsh shutdown vm-micro-os-slave-5
sudo virsh shutdown vm-micro-os-slave-6
