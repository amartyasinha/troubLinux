troubLinux
=========

A fun Ansible role to setup a Linux troubleshooting environment. Simply apply the role on a test Linux setup and enjoy troubleshooting.

**NOTE:** Troubleshooting problems are based on my experience, interviews, and internet. Feel free to contribute.

**Ongoing Project**

**WARNING:** Do not apply this role on your Production setup or daily driver. It will break your system.  

**NEW FEATURE:** Terraform support to quickly spin-up an EC2 instance and setup troubleshooting environment there (Currently working on this feature)

Requirements
------------

1. A linux VM or baremetal machine on which you can experiment. Do not use your daily driver or any Production setup which you do not want to break.
2. The role is tested on Ubuntu 22.04, but should work on majority of Linux distros.
3. A non-root user with sudo previlege.

Role Variables
--------------

Nothing critical to affect role's working.

Dependencies
------------

No dependencies as of now.

Example Playbook
----------------

Here is an example playbook included in `tests` dir. After applying this role, open a new terminal session to begin with troubleshooting and `cd begin_task` from the home dir of your non-root user.

Once you're there, open `README.txt` file to get your instructions.
```
---
- hosts: localhost
  remote_user: ubuntu
  roles:
    - ../../troubLinux
```

License
-------

MIT

Author Information
------------------

I'm [Amartya Sinha](https://github.com/amartyasinha), Cloud and DevOps Enthusiast.
