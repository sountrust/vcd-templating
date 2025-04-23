
# SNAT rule for cluster_network to reach wan
resource "vcd_nsxt_nat_rule" "snat_temp" {

  edge_gateway_id = var.edge_id

  name        = "snat_temp_rule"
  rule_type   = "SNAT"
  description = "opening to wan cluster network via SNAT rule"

  external_address = "public_ip"
  internal_address = "yuor_internal_address/CIDR"
}

# Dynamic block for DNAT rules
resource "vcd_nsxt_nat_rule" "dnat_temp_ssh" {
  for_each = var.vm_ip_out_addresses

  edge_gateway_id     = var.edge_id
  name                = "dnat temp ssh rule to ${each.key}"
  rule_type           = "DNAT"
  description         = "opening ssh to templating cluster's vm via DNAT rule"
  external_address    = "public_ip"
  internal_address    = each.value
  dnat_external_port  = 22110 + index([for k, v in var.vm_ip_out_addresses : v], each.value)
  app_port_profile_id = data.vcd_nsxt_app_port_profile.ssh.id
  firewall_match      = "MATCH_EXTERNAL_ADDRESS"
}

