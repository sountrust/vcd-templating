# Ubuntu vapp catlog output variable
output "help_cat_out_id" {
  value = data.vcd_catalog.vapp_catalog.id
}

# Ubuntu template from vapp catlog output variable
output "vapp_template_out_id" {
  value = data.vcd_catalog_vapp_template.ubuntu_2404_LTS_cloud.id
}

