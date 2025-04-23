# Getting SSH from MonacoCloud application profiles for nat AND firewall rules
data "vcd_nsxt_app_port_profile" "ssh" {

  scope = "SYSTEM"
  name  = "SSH"
}

