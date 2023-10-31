 
ROS REQUIREMENTS INSTALL
=========

Downloads required packages to build and run ROS packages properly.

![Ansible Lint](https://github.com/bounverif/ansible-collection-ros/actions/workflows/ansible-lint.yml/badge.svg)

Requirements
------------

Proper Ubuntu distribution and version must be provided in order to complete installation.

Dependencies
------------

To run this role properly ROS2 must be installed on the system.

Example Playbook
----------------

```
- name: Ros Requirements Install Role
  hosts: localhost
  connection: local
  roles:
    - role: bounverif.ros.ros_requirements_install
```

License
-------

See [license.md](https://github.com/bounverif/ansible-collection-ros/blob/main/LICENSE)

Author Information
------------------

https://github.com/bounverif/ansible-collection-ros
