# 📦 Template Terraform Environment (templating/terraform/template)

This directory defines the **template infrastructure environment** for VCloudDirector using Terraform and Ansible. It serves as a complete provisioning and configuration pipeline, combining reusable Terraform modules and post-deployment automation.

---

## 📐 Purpose

The purpose of this environment is twofold:

1. **Templated Cluster Provisioning**  
   Provision a Kubernetes-compatible cluster on VMware vCloud Director (vCD), including:
   - VM deployment via `vapp_vm`
   - VAPP-wide network setup with SNAT/DNAT
   - SSH access routing with firewall/NAT rules
   - Dynamic Ansible inventory from Terraform outputs
   - Cloud-init VM configuration via base64 user-data (cloud-config.yaml)
   - Cloud-init reset after provisioning

2. **Template Builder for Future Environments**  
   Build and configure a VAPP of predefined VMs (e.g. `c.large`, `c.xlarge`) that can later be:
   - Powered off
   - Converted to a catalog template
   - Used to resize or provision new control/worker nodes across environments (dev/preprod/prod)

---

## ⚠️ Known Limitation (Terraform)

Terraform **cannot**:
- Power off a VAPP
- Convert a VAPP into a catalog template
- Re-enable it for destruction

📌 **Manual/CLI workaround required** post-deploy.

### ✅ Option 1: vCD UI (Manual)
1. Power off the VAPP
2. Convert it into a template and assign to a catalog

### ✅ Option 2: vCD CLI (Automation)
```bash
# Power off VAPP
vcd vapp power-off <vapp-name> -o <org> -v <vdc>

# Convert to template
vcd vapp capture <vapp-name> <catalog-name> --template-name <template-name> -o <org> -v <vdc>
```

---

## 📁 Folder Structure

```bash
templating/terraform/template/
├── backend.tf                # HTTP backend
├── deploy.sh                 # Orchestrates Terraform + Ansible
├── generate_inventory.sh     # Converts TF outputs → Ansible inventory
├── locals.tf                 # Static locals (region, etc.)
├── main.tf                   # Orchestrates catalog, network, compute modules
├── outputs.tf                # Public IP, ports, debug
├── provider.tf               # vCD provider credentials
└── variables.tf              # Environment inputs (vcd_url, token, etc.)
```

---

## 🧩 Module Composition

This environment consumes:

- `../modules/catalogs` – References Ubuntu templates in `vapp_catalog`
- `../modules/computes` – VAPP + VM deployment (with cloud-init)
- `../modules/networks` – Routed org network, SNAT, DNAT rules

---

## 🚀 Usage

```bash
cd templating/terraform/template

# 1. Export secrets
source ../../../.main.env

# 2. Launch full pipeline
./deploy.sh

# 3. Convert result to template (manually or with CLI)
```

---

## 📤 Outputs

- `dnat_ssh_ports`: map of VM → SSH exposed ports
- `vm_ip_out_addresses`: internal IPs per provisioned VM
- `debug_vms_sizes`: exported sizing info per role

---

## 🔐 Secrets

All secrets (vcd credentials, tokens, orgs) must be:
- Exported from `.main.env`, or
- Passed directly in environment

---

## 📬 Maintainer

Sountrust DevOps  
📧 paul@sountrust.com
