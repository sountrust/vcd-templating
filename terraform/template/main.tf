# Data source
data "vcd_vdc_group" "main" {
  name = var.vcd_vdc_group
}

# Existing edgegateway declaration
data "vcd_nsxt_edgegateway" "existing" {
  owner_id = data.vcd_vdc_group.main.id
  name     = var.vcd_nsxt_edgegateway
}

# Calling network environment, creation and configuration
module "networks" {
  source              = "../modules/networks"
  nsxt_name           = "nsxt_temp"
  vapp_out_name       = module.computes.vapp_out_name
  vm_ip_out_addresses = module.computes.vm_ip_out_addresses
  edge_id             = data.vcd_nsxt_edgegateway.existing.id
  vdc_group_id        = data.vcd_vdc_group.main.id
}

# Calling computes creation and configuation
module "computes" {
  source            = "../modules/computes"
  vapp_name         = var.vcd_cluster_name
  vapp_net_out_name = module.networks.vapp_net_out_name
  vapp_template_id  = module.catalogs.vapp_template_out_id
}

# Calling atalogs creation and configuation
module "catalogs" {
  source = "../modules/catalogs"
}
