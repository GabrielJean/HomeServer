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

# =========================
# Docker-1
# =========================
resource "proxmox_vm_qemu" "Docker-1" {
  name        = "Docker-1"
  target_node = "pve-1"
  os_type     = "cloud-init"
  clone       = var.template_name
  cores       = 6
  sockets     = 1
  memory      = 10240
  ipconfig0   = "ip=192.168.10.11/24,gw=192.168.10.1,ip6=dhcp"

  disk {
    slot     = 0
    type     = "ide"
    storage  = "local-lvm"
    size     = "4M"
  }
  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm-2"
    size     = "40G"
    iothread = 1
  }
  disk {
    slot     = 1
    type     = "scsi"
    storage  = "local-lvm-2"
    size     = "50G"
    iothread = 1
  }
  network {
    model    = "virtio"
    bridge   = "vmbr0"
    macaddr  = "BC:24:11:4E:7E:73"
    firewall = true
  }
  ciuser  = "gabriel"
  sshkeys = <<-EOKEY
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1
EOKEY
}

# =========================
# DNS-1
# =========================
resource "proxmox_vm_qemu" "DNS-1" {
  name        = "DNS-1"
  target_node = "pve-1"
  os_type     = "cloud-init"
  clone       = var.template_name
  cores       = 2
  sockets     = 1
  memory      = 2048
  ipconfig0   = "ip=192.168.10.5/24,gw=192.168.10.1,ip6=dhcp"
  disk {
    slot     = 0
    type     = "ide"
    storage  = "local-lvm"
    size     = "4M"
  }
  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm"
    size     = "30G"
    iothread = 1
  }
  disk {
    slot     = 1
    type     = "scsi"
    storage  = "local-lvm"
    size     = "30G"
    iothread = 1
  }
  network {
    model    = "virtio"
    bridge   = "vmbr0"
    macaddr  = "BC:24:11:F1:1B:37"
    firewall = true
  }
  ciuser  = "gabriel"
  sshkeys = <<-EOKEY
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1
EOKEY
}

# =========================
# Satisfactory
# =========================
resource "proxmox_vm_qemu" "Satisfactory" {
  name        = "Satisfactory"
  target_node = "pve-1"
  os_type     = "cloud-init"
  clone       = var.template_name
  cores       = 4
  sockets     = 1
  memory      = 8192
  ipconfig0   = "ip=192.168.10.14/24,gw=192.168.10.1,ip6=dhcp"
  disk {
    slot     = 0
    type     = "ide"
    storage  = "local-lvm"
    size     = "4M"
  }
  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm"
    size     = "40G"
    iothread = 1
  }
  network {
    model    = "virtio"
    bridge   = "vmbr0"
    macaddr  = "BC:24:11:BF:F5:9C"
    firewall = true
  }
  ciuser  = "gabriel"
  sshkeys = <<-EOKEY
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1
EOKEY
}

# =========================
# Plex-1
# =========================
resource "proxmox_vm_qemu" "Plex-1" {
  name        = "Plex-1"
  target_node = "pve-1"
  os_type     = "cloud-init"
  clone       = var.template_name
  cores       = 8
  sockets     = 1
  memory      = 4096
  ipconfig0   = "ip=192.168.10.13/24,gw=192.168.10.1,ip6=dhcp"
  disk {
    slot     = 0
    type     = "ide"
    storage  = "local-lvm"
    size     = "4M"
  }
  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm"
    size     = "30G"
    iothread = 1
  }
  disk {
    slot     = 2
    type     = "scsi"
    storage  = "local-lvm"
    size     = "50G"
    iothread = 1
  }
  network {
    model    = "virtio"
    bridge   = "vmbr0"
    macaddr  = "BC:24:11:20:FA:3B"
    firewall = true
  }
  ciuser  = "gabriel"
  sshkeys = <<-EOKEY
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1
EOKEY
}

# =========================
# NAS-1 (Commented, left unchanged)
# =========================
# ...Your commented-out NAS-1 resource...

# =========================
# Ubuntu-Cloud
# =========================
resource "proxmox_vm_qemu" "Ubuntu-Cloud" {
  name        = "Ubuntu-Cloud"
  target_node = "pve-1"
  os_type     = "cloud-init"
  clone       = var.template_name
  cores       = 4
  sockets     = 1
  memory      = 4096
  ipconfig0   = "ip=dhcp,ip6=dhcp"
  disk {
    slot     = 0
    type     = "ide"
    storage  = "local-lvm"
    size     = "4M"
  }
  disk {
    slot     = 0
    type     = "scsi"
    storage  = "local-lvm"
    size     = "10G"
    iothread = 1
  }
  network {
    model    = "virtio"
    bridge   = "vmbr0"
    macaddr  = "BC:24:11:83:F1:A0"
    firewall = true
  }
  ciuser  = "gabriel"
  sshkeys = <<-EOKEY
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1
EOKEY
}