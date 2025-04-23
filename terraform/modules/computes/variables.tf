# VAPP name variable declaration for module compute
variable "vapp_name" {
  type = string
  sensitive = true
}

# VAPP name variable declaration for module compute
variable "vapp_template_id" {
  type = string
  sensitive = true
}

# VAPP network variable declaration for module compute
variable "vapp_net_out_name" {
  type = string
  sensitive = true
}

# Dynamic sizing variable 
variable "vapp_vm_attributes" {
  type = object({
    sizes = map(string)
    hostnames = map(string)
  })

  default = {
    sizes = {
      clarge = "c.large",
      cxlarge  = "c.xlarge",
      c2xlarge = "c.2xlarge",
      c4xlarge = "c.4xlarge"
    }

    hostnames = {
      clarge = "Ubuntu-24-04-large",
      cxlarge  = "Ubuntu-24-04-xlarge",
      c2xlarge = "Ubuntu-24-04-2xlarge",
      c4xlarge = "Ubuntu-24-04-4xlarge"
    }
    
  }
}

