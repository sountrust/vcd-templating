terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.11.0"
    }
  }
}



# VAPP creation
resource "vcd_vapp" "K8s_cluster" {
  name = var.vapp_name

  metadata_entry {
    key = "proof of concept"
    type = "MetadataStringValue"
    user_access = "READWRITE"
    is_system = false
    value = "VAP creation"
  }
}

# Calling sizing policies dynamically based on var.vms_sizes
data "vcd_vm_sizing_policy" "vms_sizes" {
  for_each = var.vapp_vm_attributes["sizes"]

  name = "${each.value}"
}

# Creating VMs dynamically based on var.vms_sizes
resource "vcd_vapp_vm" "vms" {
  for_each = var.vapp_vm_attributes["sizes"]

  vapp_name        = vcd_vapp.K8s_cluster.name
  name             = "ubuntu-k8s-${each.key}"
  os_type          = "ubuntu64Guest"
  vapp_template_id = var.vapp_template_id
  sizing_policy_id = data.vcd_vm_sizing_policy.vms_sizes[each.key].id
  

  network {
    name               = var.vapp_net_out_name
    type               = "org"
    ip_allocation_mode = "POOL"
  }
  #Configuration to initiate vm with cloud-init
  guest_properties = {
    "user-data" = base64encode(templatefile("${path.module}/cloud-config.yaml", {hostname = var.vapp_vm_attributes["hostnames"][each.key]}))
  }

  provisioner "local-exec" {
    command = "echo 'Debug: ${var.vapp_vm_attributes["hostnames"][each.key]}'"
  }
}
