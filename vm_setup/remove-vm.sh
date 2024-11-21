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

# delete vm
sudo virsh undefine vm-micro-os-master
sudo virsh undefine vm-micro-os-slave-1
sudo virsh undefine vm-micro-os-slave-2
sudo virsh undefine vm-micro-os-slave-3
sudo virsh undefine vm-micro-os-slave-4
sudo virsh undefine vm-micro-os-slave-5
sudo virsh undefine vm-micro-os-slave-6

# delete qcow
rm vm-micro-os-master.qcow2
rm vm-micro-os-slave-1.qcow2
rm vm-micro-os-slave-2.qcow2
rm vm-micro-os-slave-3.qcow2
rm vm-micro-os-slave-4.qcow2
rm vm-micro-os-slave-5.qcow2
rm vm-micro-os-slave-6.qcow2
