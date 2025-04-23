# 🧠 Computes Terraform Module

This module provisions and configures a set of virtual machines (VMs) in a vApp on VMware vCloud Director using pre-defined sizing policies and cloud-init templates for Kubernetes workloads.

---

## 📂 Module Overview

- **VMs** are created dynamically using `vcd_vapp_vm` and are defined via a `vapp_vm_attributes` object.
- A cloud-init script (`cloud-config.yaml`) is injected into each VM for OS-level provisioning.
- Sizing policies are mapped using `data.vcd_vm_sizing_policy`.
- Network connections are made through the provided `vapp_net_out_name`.
- The module outputs VM IPs and metadata for downstream use.

---

## 📥 Inputs

| Variable            | Description                                              | Type   | Required |
|---------------------|----------------------------------------------------------|--------|----------|
| `vapp_name`          | The name of the vApp to be created                      | string | ✅        |
| `vapp_template_id`   | The ID of the template to clone VMs from                | string | ✅        |
| `vapp_net_out_name`  | The name of the vApp network to attach VMs to           | string | ✅        |
| `vapp_vm_attributes` | Object defining VM sizes and hostnames                  | object | ❌ (default provided) |

### Example

```hcl
vapp_vm_attributes = {
  sizes = {
    clarge    = "c.large",
    cxlarge   = "c.xlarge"
  },
  hostnames = {
    clarge    = "Ubuntu-24-04-large",
    cxlarge   = "Ubuntu-24-04-xlarge"
  }
}
```

---

## 📤 Outputs

| Output Name         | Description                                 |
|---------------------|---------------------------------------------|
| `vapp_out_name`      | Name of the created vApp                   |
| `vm_ip_out_addresses`| Map of VM names to IP addresses            |
| `debug_vms_sizes`    | Outputs VM sizes for debug or logging      |

---

## 📘 Notes

- The module uses a base64-encoded `cloud-config.yaml` template to pass user data for cloud-init.
- Useful for initializing VMs with a specific user, package installs, DNS settings, and SSH access.
- Cloud-init automatically restarts DNS services and configures `cloud-user`.

---

## 🛠️ Usage Example

```hcl
module "computes" {
  source            = "../modules/computes"
  vapp_name         = "example-cluster"
  vapp_template_id  = "template-id"
  vapp_net_out_name = "vapp-network"

  vapp_vm_attributes = {
    sizes = {
      small  = "c.small",
      medium = "c.medium"
    },
    hostnames = {
      small  = "vm-small",
      medium = "vm-medium"
    }
  }
}
```
