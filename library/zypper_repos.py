#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright (c) 2024, Leo Manfredi
#
# GNU General Public License v3.0+ (see LICENSES/GPL-3.0-or-later.txt or https://www.gnu.org/licenses/gpl-3.0.txt)
# SPDX-License-Identifier: GPL-3.0-or-later

DOCUMENTATION = r'''
module: zypper_repos
short_description: repos list
description:
  - List all defined repositories
author: Leo Manfredi
options:
  show_enabled_only:
    description: show only enabled
    default: True
    required: False
    type: bool
'''

EXAMPLES = r'''
- name: repo status
  zypper_repos:
    show_enabled_only: no
  register: result

- name: repo status
  zypper_repos:
  register: result
'''

RETURN = r'''
changed:
  description: If a change is made
  returned: always
  type: boolean
check_mode:
  description: If playbook is run as check_mode 
  returned: always
  type: boolean
repos:
  description: The list of repos 
  returned: always
  type: list
  elements: dict
  contains:
    alias:
      description: The alias of the repository
      type: str
    enabled:
      description: 1 for enabled, 0 for disabled
      type: str
    uri:
      description: The URI of the repository
      type: str
  sample: [ 
            { 
              "alias": "repo-openh264",
              "enabled": "1",
              "uri": "http://codecs.opensuse.org/openh264/openSUSE_Leap/"
            }
          ]
'''

from ansible.module_utils.basic import AnsibleModule
import configparser

class ZypperRepos:
    '''
    Helper class for zypper repos
    '''
    def __init__(self, module, params):
        self.module = module
        self.params = params
    
    def repos(self):
        command = 'zypper lr -e -'
        rc, out, err = self.module.run_command(command, use_unsafe_shell = True)
        # rc = 6 for "No repositories defined" 
        if rc != 0 and rc != 6:
            self.module.fail_json(msg="Command failed rc=%d, out=%s, err=%s, commnad=%s" % (rc, out, err, command))
    
        # see https://docs.python.org/3/library/configparser.html
        config_object = configparser.ConfigParser()
        config_object.read_string(out)
        output_list = list()
        sections = config_object.sections()
        for section in sections:
            alias = section
            enabled = config_object.get(section, 'enabled')
            uri = config_object.get(section, 'baseurl')
            output_list.append({ "alias": alias, "enabled": enabled, "uri": uri })
                
        if self.params['show_enabled_only']:
            output_list = [ repo for repo in output_list if repo["enabled"] == "1" ]

        return output_list, command



def main():
    argument_spec = {
        "show_enabled_only": {"type": "bool", "required": False, "default": True}
    }

    json = {
        "changed": False,
        "check_mode": False
    }

    module = AnsibleModule(
        argument_spec = argument_spec,
        supports_check_mode = True
    )

    if module.check_mode:
        json["check_mode"] = True
        module.exit_json(**json)
    

    params = dict(
        show_enabled_only = bool(module.params['show_enabled_only'])
    )

    zypper = ZypperRepos(module, params)
    repos, _ = zypper.repos()
    json["repos"] = repos
    
    module.exit_json(**json)


if __name__ == '__main__':
    main()


# Usage: e.g
# ANSIBLE_LIBRARY=./library ansible -m zypper_repos localhost
# ANSIBLE_LIBRARY=./library ansible -m zypper_repos -a "show_enabled_only=no" localhost
# ANSIBLE_LIBRARY=./library ansible -u root -i inventory.yaml micro-os -m zypper_repos
# ANSIBLE_PYTHON_INTERPRETER=auto_silent ANSIBLE_LIBRARY=./library ansible -u root -i inventory.yaml -m zypper_repos
# ANSIBLE_PYTHON_INTERPRETER=auto_silent ANSIBLE_LIBRARY=./library ansible -u root -i inventory.yaml micro-os -m zypper_repos
# ansible-doc -M ./library zypper_repos

# See also:
# https://docs.ansible.com/ansible/latest/collections/community/general/index.html
# https://docs.ansible.com/ansible/latest/collections/community/general/zypper_module.html
# https://docs.ansible.com/ansible/latest/collections/community/general/zypper_repository_module.html
# ansible-galaxy collection install community.general
