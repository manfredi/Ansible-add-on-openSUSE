#!/usr/bin/env bash
set -e

# Copy your ssh pub key into master/slaves machines
for i in {0..6}
do
  sshpass -p "nots3cr3t" ssh-copy-id -o StrictHostKeyChecking=no root@192.168.122.4$i
done

