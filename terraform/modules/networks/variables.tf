# VAPP network variable declaration 
variable "vapp_out_name" {
  type = string
  sensitive = true
}

# NSXT network variable declaration 
variable "nsxt_name" {
  type = string
  sensitive = true
}

# NSXT edgegateway id variable declaration 
variable "edge_id" {
  type = string
  sensitive = true
}

# VAPP worker's vm ip variable declaration
variable "vm_ip_out_addresses" {
  type = map(string)
}

# VDC group id variable declaration 
variable "vdc_group_id" {
  type = string
  sensitive = true
}
