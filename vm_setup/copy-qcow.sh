#!/usr/bin/env bash
set -e

[ ! -e openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 ] && wget https://download.opensuse.org/tumbleweed/appliances/openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2

cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-master.qcow2

cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-slave-1.qcow2
cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-slave-2.qcow2
cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-slave-3.qcow2
cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-slave-4.qcow2
cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-slave-5.qcow2
cp openSUSE-MicroOS.x86_64-kvm-and-xen.qcow2 vm-micro-os-slave-6.qcow2
