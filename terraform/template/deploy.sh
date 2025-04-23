#!/bin/bash

### Templating environment
terr_dir="./"
echo "Terraform directory: $terr_dir"


# Run Terraform to provision the VM
terraform -chdir="$terr_dir" init
terraform -chdir="$terr_dir" plan 
terraform -chdir="$terr_dir" apply -auto-approve &

# Wait for the background job to finish
wait

# Get VMs' ports wrote into a hosts file
echo "Get VMs' ports wrote into a hosts file"
./generate_inventory.sh > ../../ansible/hosts.yml

# Wait for vms to be ready: 2 min
sleep 120
# Run Ansible playbook to install Kubernetes
echo "Let's play with ansible now!"
ansible-playbook -i ../../ansible/hosts.yml ../../ansible/templatingVm.yml

# Reset cloud-init on VMs
echo "Resetting cloud-init on VMs"
ansible-playbook -i ../../ansible/hosts.yml ../../ansible/reset-cloud-init.yml

