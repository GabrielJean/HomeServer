terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">= 2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true
}

# --- VM Definitions from Ansible Inventory ---
# For VMs that already exist, import them before running `terraform apply`:
# terraform import proxmox_vm_qemu.<name> <node>/qemu/<vmid>

resource "proxmox_vm_qemu" "DNS-1" {
  name        = "DNS-1"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 2048
  ipconfig0   = "ip=192.168.10.5/24,gw=192.168.10.1"
  disk {
    size = "16G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "DNS-2" {
  name        = "DNS-2"
  target_node = var.pm_node2
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 2048
  ipconfig0   = "ip=192.168.15.5/24,gw=192.168.15.1"
  disk {
    size = "16G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "Plex-1" {
  name        = "Plex-1"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 4
  memory      = 4096
  ipconfig0   = "ip=192.168.10.13/24,gw=192.168.10.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "NAS-1" {
  name        = "NAS-1"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 4096
  ipconfig0   = "ip=192.168.10.12/24,gw=192.168.10.1"
  disk {
    size = "64G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "Docker-1" {
  name        = "Docker-1"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 2048
  ipconfig0   = "ip=192.168.10.11/24,gw=192.168.10.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "Satisfactory" {
  name        = "Satisfactory"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 4
  memory      = 4096
  ipconfig0   = "ip=192.168.10.14/24,gw=192.168.10.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "Docker-2" {
  name        = "Docker-2"
  target_node = var.pm_node2
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 2048
  ipconfig0   = "ip=192.168.15.11/24,gw=192.168.15.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "k8s-master-1" {
  name        = "k8s-master-1"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 4096
  ipconfig0   = "ip=192.168.10.20/24,gw=192.168.10.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "k8s-worker-1" {
  name        = "k8s-worker-1"
  target_node = var.pm_node1
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 4096
  ipconfig0   = "ip=192.168.10.21/24,gw=192.168.10.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}

resource "proxmox_vm_qemu" "k8s-worker-2" {
  name        = "k8s-worker-2"
  target_node = var.pm_node2
  clone       = var.template_name
  os_type     = "cloud-init"
  cores       = 2
  memory      = 4096
  ipconfig0   = "ip=192.168.15.22/24,gw=192.168.15.1"
  disk {
    size = "32G"
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  sshkeys = file(var.ssh_public_key)
  ciuser  = var.ci_user
}
