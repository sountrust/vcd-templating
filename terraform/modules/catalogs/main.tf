terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.11.0"
    }
  }
}

# Existing catalog declaration
data "vcd_catalog" "vapp_catalog" {
  name = "vapp_catalog"

}

# Existing VAPP template declaration
data "vcd_catalog_vapp_template" "ubuntu_2310_cloud" {
  catalog_id = data.vcd_catalog.vapp_catalog.id
  name       = "ubuntu_2310_cloud"
}

# Existing VAPP template declaration
data "vcd_catalog_vapp_template" "ubuntu_2404_LTS_cloud" {
  catalog_id = data.vcd_catalog.vapp_catalog.id
  name       = "ubuntu_2404_LTS_cloud"
}

