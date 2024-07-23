troubLinux
=========

A fun Ansible role to setup a Linux troubleshooting environment. Simply apply the role on a test Linux setup and enjoy troubleshooting.

**NOTE:** Troubleshooting problems are based on my experience, interviews, and internet. Feel free to contribute.

**Ongoing Project**

**WARNING:** Do not apply this role on your Production setup or daily driver. It will break your system.  

**NEW FEATURE:** Terraform support to quickly spin-up an EC2 instance and setup troubleshooting environment there

Requirements
------------

1. A linux VM or baremetal machine on which you can experiment. Do not use your daily driver or any Production setup which you do not want to break.
2. The role is tested on Ubuntu 22.04, but should work on majority of Linux distros.
3. A non-root user with sudo previlege.
4. Terraform and Ansible installed on your machine. You can now use Terraform to automatically provision an EC2 instance for troubleshooting env.

Role Variables
--------------

Nothing critical to affect role's working.

Dependencies
------------

No dependencies as of now.

Example Playbook
----------------

### 1. Local Setup
If you want to setup on your own machine, directly apply this role through a similar playbook. If you are planning to automatically provision an EC2 instance for troubLinux, skip to next section.

Here is an example playbook included in `tests` dir. After applying this role, open a new terminal session to begin with troubleshooting and `cd begin_task` from the home dir of your non-root user.

Once you're there, open `README.txt` file to get your instructions.
```
---
- hosts: localhost
  remote_user: ubuntu
  roles:
    - troubLinux
```
### 2. Terraform Provisioned EC2 instance
Go to `terraform` directory. Open `terraform.tfvars` file and edit `aws_credentials` variable. You'll also need to edit `key_name` in `instance_config` var. Make sure you have already created that key in the region where you want your deployment.


Once you are done with this, run the following command:
```
terraform init
terraform plan
terraform apply --auto-approve
```

That's all, terraform will create an EC2 instance and automatically run the ansible role to setup troubleshooting env.

**NOTE:** Make sure you create the key in the correct region. Otherwise, terraform will not be able to find the key.

License
-------

MIT

Author Information
------------------

I'm [Amartya Sinha](https://github.com/amartyasinha), Cloud and DevOps Enthusiast.
