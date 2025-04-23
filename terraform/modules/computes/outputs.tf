# Vapp name output variable
output "vapp_out_name" {
  value = vcd_vapp.K8s_cluster.name
}

# Dynamic outputs ip addresses on vapp_vm
output "vm_ip_out_addresses" {
  value = { for idx, vm in vcd_vapp_vm.vms : idx => vm.network[0].ip }
}
output "debug_vms_sizes" {
  value = { for key, value in var.vapp_vm_attributes["sizes"] : key => value }
}
