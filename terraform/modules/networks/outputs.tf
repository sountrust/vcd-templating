# VAPP org network output name
output "vapp_net_out_name" {
  value = vcd_vapp_org_network.cluster_network.org_network_name
}

# Dynamic outputs for DNAT rules
output "dnat_ssh_ports" {
  value = { for key in keys(var.vm_ip_out_addresses) : key => 22110 + index([for v in values(var.vm_ip_out_addresses) : v], var.vm_ip_out_addresses[key]) }
}
