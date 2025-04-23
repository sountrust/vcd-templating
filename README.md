# 🧰 VCloudDirector Templating Submodule

This repository provides a complete infrastructure templating workflow for VCloudDirector using Terraform and Ansible. It is designed to provision reusable VM templates and manage network and catalog resources across different VCloudDirector environments (dev, pre-prod, prod).

---

## 📦 Repository Structure

```bash
templating/
├── ansible/                      # Post-provisioning setup for templated VMs
│   ├── kubelet-config.yaml
│   ├── reset-cloud-init.yml
│   ├── templatingVm.yml
│   └── README.md
└── terraform/
    ├── cataloging/               # Git submodule for catalog OVA management
    │   ├── cloudImg/
    │   │   └── build-u2404-noble-latest.sh
    │   └── README.md
    ├── networking/               # Git submodule for firewall & port profiles
    │   └── README.md
    ├── modules/                  # Terraform reusable modules
    │   ├── catalogs/
    │   │   └── README.md
    │   ├── computes/
    │   │   └── README.md
    │   └── networks/
    │       └── README.md
    └── template/                 # Root environment to orchestrate modules
        └── README.md
```

---

## 🔌 Git Submodules

This repository relies on the following Git submodules for modular reuse:

| Submodule    | Path                    | Description                                   |
|--------------|-------------------------|-----------------------------------------------|
| cataloging   | `terraform/cataloging`  | Handles catalog and image registration        |
| networking   | `terraform/networking`  | Manages NSX-T firewall and port configurations |

Make sure to clone with submodules:

```bash
git clone --recurse-submodules <repo-url>
```

To update all submodules (and their submodules), run:

```bash
git submodule update --init --recursive
```

---

## 🎯 Purpose

- Produce reusable templates of VMs using catalog images
- Build ready-to-use infrastructure pieces (network, compute, firewall)
- Orchestrate VM provisioning and post-deployment configuration
- Feed Kubernetes environments with dynamic infrastructure baselines

---

## 🚀 Deployment Entry Point

The main execution happens in:

```bash
terraform/template/
```

See the [`template/README.md`](terraform/template/README.md) for detailed usage and deployment flow.

---

## 📖 Submodule & Component Documentation

Each submodule and Terraform module in this repository includes its own dedicated `README.md` for usage, architecture, and configuration details:

| Path                                      | Description                               |
|-------------------------------------------|-------------------------------------------|
| `terraform/template/README.md`           | Main template deployment execution flow   |
| `terraform/cataloging/README.md`         | Catalog creation and image management     |
| `terraform/networking/README.md`         | Networking and firewall configuration     |
| `terraform/modules/catalogs/README.md`   | Reuse logic for vApp templates            |
| `terraform/modules/computes/README.md`   | Dynamic compute/VApp provisioning         |
| `terraform/modules/networks/README.md`   | VApp network and DNAT/SNAT logic          |
| `ansible/README.md`                      | Ansible playbooks used post-TF            |

Each of these directories can be maintained and versioned independently if needed, particularly `cataloging` and `networking`, which are included as Git submodules.

---

## 🚀 Deployment Entry Point

The main execution happens in:

```bash
terraform/template/
## 📬 Maintainers

Sountrust DevOps — [paul@sountrust.com](mailto:paul@sountrust.com)
