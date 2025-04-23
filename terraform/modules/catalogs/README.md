# 📦 Terraform Module – `catalogs`

This module is responsible for **referencing existing vApp templates** within the `vapp_catalog` on a VMware vCloud Director (vCD) infrastructure. It is designed to be consumed by other modules (like `computes`) that require access to these VM templates for instantiating virtual machines in Kubernetes clusters.

---

## 🧭 Purpose

- Retrieve the ID of the shared catalog (`vapp_catalog`)
- Access predefined Ubuntu vApp templates stored in the catalog:
  - `ubuntu_2310_cloud`
  - `ubuntu_2404_LTS_cloud`
- Output vApp template IDs for use in compute provisioning

---

## 🏗️ Structure

```
catalogs/
├── main.tf        # Terraform data sources referencing catalog and templates
└── outputs.tf     # Outputs exposing IDs of catalog and templates
```

---

## 🔌 Inputs

None – this module operates on **pre-existing catalog resources** and requires no input variables.

---

## 📤 Outputs

| Output Name           | Description                                     |
|-----------------------|-------------------------------------------------|
| `help_cat_out_id`     | ID of the `vapp_catalog`                |
| `vapp_template_out_id`| ID of the `ubuntu_2404_LTS_cloud` template     |

---

## 📎 Usage

```hcl
module "catalogs" {
  source = "../modules/catalogs"
}

output "catalog_id" {
  value = module.catalogs.help_cat_out_id
}

output "template_id" {
  value = module.catalogs.vapp_template_out_id
}
```

---

## 🔒 Notes

- Both Ubuntu templates must be pre-uploaded in `vapp_catalog` in vCD.
- Terraform does not create catalog entries here — it only references them.

