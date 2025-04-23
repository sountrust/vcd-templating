terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.11.0"
    }
  }
}

# Create a new network in organization VDC defined in branch_name folder
data "vcd_network_routed_v2" "temp_network" {
  name = var.nsxt_name
  edge_gateway_id = var.edge_id
}


# Create a new vapp network in organization VDC defined in branch_name folder
resource "vcd_vapp_org_network" "cluster_network" {
  vapp_name = var.vapp_out_name
  org_network_name = data.vcd_network_routed_v2.temp_network.name
  reboot_vapp_on_removal = true
}

