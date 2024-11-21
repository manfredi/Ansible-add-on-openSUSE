#!/bin/bash
# combustion: network
# script generated with https://opensuse.github.io/fuel-ignition/

# Redirect output to the console
exec > >(exec tee -a /dev/tty0) 2>&1

# Keyboard
systemd-firstboot --force --keymap=it

# Timezone
systemd-firstboot --force --timezone=Europe/Rome

# Set a password for root, generate the hash with "openssl passwd -6"
echo 'root:$6$gcsk3U0f55lDpxXM$aXGBErgXbo07PCDtPQnfdNU0gPS5OOrICqvOFjJWJHhWs8Tf4K8llfzzVE6ZMwmU8d7MUn/DAjUkMOU/mSYUQ0' | chpasswd -e
# echo 'root:nots3cr3t' | chpasswd

# See https://www.man7.org/linux/man-pages/man5/sshd_config.5.html
# root can log in using ssh
echo "PermitRootLogin yes" > /etc/ssh/sshd_config.d/10-PermitRootLogin.conf

# Enable sshd
mkdir -pm700 /root/.ssh/
systemctl enable sshd.service

# Install Additional Packages
zypper --non-interactive install python3

# Leave a marker
echo "Configured with combustion" > /etc/issue.d/combustion

# Close outputs and wait for tee to finish.
exec 1>&- 2>&-; wait;
