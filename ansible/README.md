# 🧪 Ansible — Templating Setup for VCloudDirector VMs

This folder contains the Ansible playbooks and configuration used after Terraform deployment in the `template` environment of VCloudDirector. It prepares each VM for use as a Kubernetes-compatible template.

---

## 📜 Playbooks & Files

### `templatingVm.yml`

This playbook installs and configures Kubernetes-related components on Ubuntu 24.04 VMs:

- Installs containerd and Kubernetes binaries (kubelet, kubeadm, kubectl)
- Adds Kubernetes APT repository with GPG key
- Sets up containerd with `SystemdCgroup = true` and AppArmor disabled
- Enables IP forwarding and br_netfilter
- Reboots and continues configuration post-reboot
- Copies `kubelet-config.yaml` for predefined Kubelet settings

### `reset-cloud-init.yml`

Used to clean cloud-init state before capturing the VM as a template:

- Runs `cloud-init clean`
- Ensures a fresh initialization next time the image is used

### `kubelet-config.yaml`

Configuration applied to kubelet (via Ansible) with:

- Proper DNS and domain
- Logging setup
- cgroupDriver set to `systemd`
- Static pod path enabled

---

## ⚙️ Usage

This folder is invoked automatically by the `deploy.sh` script in `../terraform/template/`.

If needed, it can be run independently:

```bash
ansible-playbook -i hosts.yml templatingVm.yml
ansible-playbook -i hosts.yml reset-cloud-init.yml
```

---

## 🔒 Privileges

All playbooks assume `cloud-user` as the SSH user and require sudo privileges (`become: true`).

---

## 👥 Maintainer

Sountrust DevOps — [paul@sountrust.com](mailto:paul@sountrust.com)
