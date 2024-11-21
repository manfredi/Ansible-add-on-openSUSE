# HackWeek#24

`Ansible-add-on-openSUSE`: __HackWeek#24__ experiments

See Project [Ansible for add-on management](https://hackweek.opensuse.org/24/projects/ansible-for-add-on-management)


## Goals

This project is a *PoC* about how to use [Ansible](https://docs.ansible.com/ansible/latest/index.html) for add-on managements in [openSUSE](https://www.opensuse.org/) (only *repos* for now).

This is a work-in-progress.

Create the initial repository list then use this list of repos to reset the machine at its initial, cleaned state.

Add-on products are system extensions.

See [Using Zypper](https://doc.opensuse.org/documentation/leap/reference/html/book-reference/cha-sw-cl.html#sec-zypper)

```bash
# see
zypper repos
zypper products
zypper patterns
zypper packages
zypper patches
```

References:

- [openSUSE Server Distributions](https://get.opensuse.org/server/)
- [Basic VM Guest management](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/cha-libvirt-managing.html)
- [Config Generator](https://opensuse.github.io/fuel-ignition/)


## Steps to run PoC in VM

Note: *Keyboard* and *Timezone* are set to `it` and `Europe/Rome`.
Change it to fit your needs by edit the related *combustion* files.

Inside folder `vm_setup`:

1. run `copy_qcow.sh`
2. run `vm-slaves.sh`
3. wait until vm are ready to login
4. run `vm-master.sh`
5. wait until vm is ready to login
6. run `copy_sshkey.sh`

Inside project folder:

7. sync repo into master machine 
   - `rsync -ar --exclude 'vm_setup' . root@192.168.122.40:/root/HackWeek24/`
8. ssh into master and run playbooks
   - `ssh -o StrictHostKeyChecking=no root@192.168.122.40`
   ```bash
   vm-micro-os-master:~ # cd HackWeek24
   vm-micro-os-master:~/HackWeek24 # ansible-playbook -i inventory.yaml playbook-getrepo.yaml
   ...
   vm-micro-os-master:~/HackWeek24 # cd dump
   vm-micro-os-master:~/HackWeek24/dump # ls -l
   ...
   vm-micro-os-master:~/HackWeek24/dump # cd ..
   vm-micro-os-master:~/HackWeek24 # ansible-playbook -i inventory.yaml playbook-addrepo.yaml
   ...
   # check repo in slaves, e.g.
   vm-micro-os-master:~/HackWeek24 # ssh root@vm-micro-os-slave-6
   vm-micro-os-slave-6:~ # zypper repos
   ```
        


```bash
# to login inside machines:
ssh -o StrictHostKeyChecking=no root@192.168.122.40
ssh -o StrictHostKeyChecking=no root@192.168.122.41
ssh -o StrictHostKeyChecking=no root@192.168.122.42
ssh -o StrictHostKeyChecking=no root@192.168.122.43
ssh -o StrictHostKeyChecking=no root@192.168.122.44
ssh -o StrictHostKeyChecking=no root@192.168.122.45
ssh -o StrictHostKeyChecking=no root@192.168.122.46
```
