# ansibletools
This project is for creating a general utility environment for running Ansible.  Installing Ansible is slow and has no official image.  

Tools included are for running modules/lookups for terraform, helm, kubenetes, Hashicorp Vault, and along with other misc.

## Similar projects/references:
* https://github.com/cytopia/docker-ansible
* https://github.com/GabLeRoux/ansible-docker-image

## Notes
Switching away from alpine linux as a base due to not having many python precompiled wheel packages