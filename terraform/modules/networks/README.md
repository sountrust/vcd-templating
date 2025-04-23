# 🧩 Terraform Module – Networks

This module is part of the VCloudDirector Templating Stack. It provisions network-related components in vCloud Director (vCD) using NSX-T, including routed networks and DNAT/SNAT rules for a templating Kubernetes cluster.

---

## 📂 Structure

This folder contains the following files:

- `app-port-profile.tf`: Declares port profiles required by DNAT rules.
- `network.tf`: Creates NSX-T routed and vApp networks for the templating environment.
- `nat.tf`: Configures NAT rules (SNAT/DNAT) for external access.
- `locals.tf`: Defines the region or contextual values.
- `variables.tf`: Inputs required from the main module.
- `outputs.tf`: Outputs to be consumed by other modules.
- `README.md`: This documentation.

---

## ⚙️ Resources Managed

### 🔌 Port Profiles

The module fetches system port profile for SSH (`SYSTEM/SSH`) to use it in firewall and NAT rules.

```hcl
data "vcd_nsxt_app_port_profile" "ssh" {
  scope = "SYSTEM"
  name  = "SSH"
}
```

---

### 🌐 Network

A routed Org VDC network is retrieved using:

```hcl
data "vcd_network_routed_v2" "temp_network"
```

Then used to create a vApp network attached to the VMs:

```hcl
resource "vcd_vapp_org_network" "cluster_network"
```

---

### 🔁 NAT Rules

- **SNAT**: Allows templating cluster to reach the internet.
- **DNAT**: Exposes SSH access per VM using calculated ports in the 22110+ range.

DNAT rules are dynamically generated for each VM IP:

```hcl
resource "vcd_nsxt_nat_rule" "dnat_temp_ssh" {
  for_each = var.vm_ip_out_addresses
  ...
}
```

---

## 🔐 Variables

| Name                | Description                              | Type         |
|---------------------|------------------------------------------|--------------|
| `vapp_out_name`     | Name of the target vApp                  | `string`     |
| `nsxt_name`         | NSX-T Routed Network name                | `string`     |
| `edge_id`           | NSX-T Edge Gateway ID                    | `string`     |
| `vdc_group_id`      | VDC Group ID                             | `string`     |
| `vm_ip_out_addresses`| Map of VM names to their private IPs   | `map(string)`|

---

## 📤 Outputs

| Name             | Description                                |
|------------------|--------------------------------------------|
| `vapp_net_out_name` | Name of the connected vApp network       |
| `dnat_ssh_ports`    | Map of VM names to their SSH DNAT ports  |

---

## 🗺️ Usage

```hcl
module "networks" {
  source = "../module/networks"
  nsxt_name = "nsxt_temp"
  vapp_out_name = module.computes.vapp_out_name
  vm_ip_out_addresses = module.computes.vm_ip_out_addresses
  edge_id = data.vcd_nsxt_edgegateway.existing.id
  vdc_group_id = data.vcd_vdc_group.main.id
}
```

---

## 🏷️ Notes

- DNAT port ranges start at `22110`.
- This module is templating-specific and assumes static NAT IPs.
- SSH traffic is exposed through the firewall via system port profiles.
