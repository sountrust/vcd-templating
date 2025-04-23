# Root module output for DNAT SSH ports
output "dnat_ssh_ports" {
  value = module.networks.dnat_ssh_ports
}

# Debug purpose
output "debug_vms_sizes" {
  value = module.computes.debug_vms_sizes
}

# Dynamic outputs ip addresses on vapp_vm
output "vm_ip_out_addresses" {
  value = module.computes.vm_ip_out_addresses
}
