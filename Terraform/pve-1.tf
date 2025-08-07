
# ==============================================
# Ubuntu-Cloud (TEMPLATE)
# ==============================================
resource "proxmox_virtual_environment_vm" "Ubuntu-Cloud" {
  provider = proxmox.pve1
  name            = "Ubuntu-Cloud"
  node_name       = "pve-1"
  scsi_hardware   = "virtio-scsi-single"
  started         = false
  tablet_device   = true
  tags            = []
  template        = true
  vm_id           = 101
  keyboard_layout = "en-us"
  migrate         = false
  on_boot         = true
  reboot          = false
  reboot_after_update = true
  stop_on_destroy = false
  timeout_clone        = 1800
  timeout_create       = 1800
  timeout_migrate      = 1800
  timeout_reboot       = 1800
  timeout_shutdown_vm  = 1800
  timeout_start_vm     = 1800
  timeout_stop_vm      = 300

  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }

  cpu {
    cores        = 4
    sockets      = 1
    type         = "x86-64-v2-AES"
    numa         = true
    limit        = 0
    hotplugged   = 0
    units        = 1024
    flags        = []
    architecture = null
    affinity     = null
  }

  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "base-101-disk-0"
    replicate         = true
    serial            = null
    size              = 10
    ssd               = false
  }

  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = "BC:24:11:83:F1:A0"
    firewall    = true
    enabled     = true
    disconnected = false
    mtu         = 0
    queues      = 0
    rate_limit  = 0
    trunks      = null
    vlan_id     = 0
  }

  initialization {
    datastore_id         = "local-lvm"
    interface            = "ide0"
    meta_data_file_id    = null
    network_data_file_id = null
    type                 = null
    user_data_file_id    = null
    vendor_data_file_id  = null

    dns {
      domain  = "gwebs.ca"
      servers = ["192.168.10.5"]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
        gateway = null
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"
      ]
      password = null
    }
  }

  operating_system {
    type = "l26"
  }
}

# ==============================================
# DNS-1
# ==============================================
resource "proxmox_virtual_environment_vm" "DNS-1" {
  provider = proxmox.pve1
  name            = "DNS-1"
  node_name       = "pve-1"
  scsi_hardware   = "virtio-scsi-single"
  started         = true
  tablet_device   = true
  tags            = []
  template        = false
  vm_id           = 102
  keyboard_layout = "en-us"
  migrate         = false
  on_boot         = true
  reboot          = false
  reboot_after_update = true
  stop_on_destroy = false
  timeout_clone        = 1800
  timeout_create       = 1800
  timeout_migrate      = 1800
  timeout_reboot       = 1800
  timeout_shutdown_vm  = 1800
  timeout_start_vm     = 1800
  timeout_stop_vm      = 300

  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }

  cpu {
    cores        = 2
    sockets      = 1
    type         = "x86-64-v2-AES"
    numa         = true
    limit        = 0
    hotplugged   = 0
    units        = 1024
    flags        = []
    architecture = null
    affinity     = null
  }

  memory {
    dedicated      = 2048
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-102-disk-0"
    replicate         = true
    serial            = null
    size              = 30
    ssd               = false
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi1"
    iothread          = true
    path_in_datastore = "vm-102-disk-1"
    replicate         = true
    serial            = null
    size              = 30
    ssd               = false
  }

  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = "BC:24:11:F1:1B:37"
    firewall    = true
    enabled     = true
    disconnected = false
    mtu         = 0
    queues      = 0
    rate_limit  = 0
    trunks      = null
    vlan_id     = 0
  }

  initialization {
    datastore_id         = "local-lvm"
    interface            = "ide0"
    meta_data_file_id    = null
    network_data_file_id = null
    type                 = null
    user_data_file_id    = null
    vendor_data_file_id  = null

    dns {
      domain  = "gwebs.ca"
      servers = ["192.168.10.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.10.5/24"
        gateway = "192.168.10.1"
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"
      ]
      password = null
    }
  }

  operating_system {
    type = "l26"
  }

  startup {
    order      = 1
    up_delay   = 20
    down_delay = -1
  }
}

# ==============================================
# Plex-1
# ==============================================
resource "proxmox_virtual_environment_vm" "Plex-1" {
  provider = proxmox.pve1
  name            = "Plex-1"
  node_name       = "pve-1"
  scsi_hardware   = "virtio-scsi-single"
  started         = true
  tablet_device   = true
  tags            = []
  template        = false
  vm_id           = 103
  keyboard_layout = "en-us"
  migrate         = false
  on_boot         = true
  reboot          = false
  reboot_after_update = true
  stop_on_destroy = false
  timeout_clone        = 1800
  timeout_create       = 1800
  timeout_migrate      = 1800
  timeout_reboot       = 1800
  timeout_shutdown_vm  = 1800
  timeout_start_vm     = 1800
  timeout_stop_vm      = 300

  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }

  cpu {
    cores        = 8
    sockets      = 1
    type         = "x86-64-v2-AES"
    numa         = true
    limit        = 0
    hotplugged   = 0
    units        = 1024
    flags        = []
    architecture = null
    affinity     = null
  }

  memory {
    dedicated      = 4096
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-103-disk-0"
    replicate         = true
    serial            = null
    size              = 30
    ssd               = false
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi2"
    iothread          = true
    path_in_datastore = "vm-103-disk-2"
    replicate         = true
    serial            = null
    size              = 50
    ssd               = false
  }

  hostpci {
    device   = "hostpci0"
    id       = "0000:06:00"
    mapping  = null
    mdev     = null
    pcie     = false
    rom_file = null
    rombar   = true
    xvga     = false
  }

  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = "BC:24:11:20:FA:3B"
    firewall    = true
    enabled     = true
    disconnected = false
    mtu         = 0
    queues      = 0
    rate_limit  = 0
    trunks      = null
    vlan_id     = 0
  }

  initialization {
    datastore_id         = "local-lvm"
    interface            = "ide0"
    meta_data_file_id    = null
    network_data_file_id = null
    type                 = null
    user_data_file_id    = null
    vendor_data_file_id  = null

    dns {
      domain  = "gwebs.ca"
      servers = ["192.168.10.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.10.13/24"
        gateway = "192.168.10.1"
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"
      ]
      password = null
    }
  }

  operating_system {
    type = "l26"
  }

  startup {
    order      = 3
    up_delay   = -1
    down_delay = -1
  }
}

# ==============================================
# Docker-1
# ==============================================
resource "proxmox_virtual_environment_vm" "Docker-1" {
  provider = proxmox.pve1
  name            = "Docker-1"
  node_name       = "pve-1"
  scsi_hardware   = "virtio-scsi-single"
  started         = true
  tablet_device   = true
  tags            = []
  template        = false
  vm_id           = 105
  keyboard_layout = "en-us"
  migrate         = false
  on_boot         = true
  reboot          = false
  reboot_after_update = true
  stop_on_destroy = false
  timeout_clone        = 1800
  timeout_create       = 1800
  timeout_migrate      = 1800
  timeout_reboot       = 1800
  timeout_shutdown_vm  = 1800
  timeout_start_vm     = 1800
  timeout_stop_vm      = 300

  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }

  cpu {
    cores        = 6
    sockets      = 1
    type         = "x86-64-v2-AES"
    numa         = true
    limit        = 0
    hotplugged   = 0
    units        = 1024
    flags        = []
    architecture = null
    affinity     = null
  }

  memory {
    dedicated      = 10240
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm-2"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-105-disk-1"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm-2"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi1"
    iothread          = true
    path_in_datastore = "vm-105-disk-0"
    replicate         = true
    serial            = null
    size              = 50
    ssd               = false
  }

  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = "BC:24:11:4E:7E:73"
    firewall    = true
    enabled     = true
    disconnected = false
    mtu         = 0
    queues      = 0
    rate_limit  = 0
    trunks      = null
    vlan_id     = 0
  }

  initialization {
    datastore_id         = "local-lvm"
    interface            = "ide0"
    meta_data_file_id    = null
    network_data_file_id = null
    type                 = null
    user_data_file_id    = null
    vendor_data_file_id  = null

    dns {
      domain  = "gwebs.ca"
      servers = ["192.168.10.5"]
    }

    ip_config {
      ipv4 {
        address = "192.168.10.11/24"
        gateway = "192.168.10.1"
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"
      ]
      password = null
    }
  }

  operating_system {
    type = "l26"
  }

  startup {
    order      = 4
    up_delay   = -1
    down_delay = -1
  }
}

# ==============================================
# Satisfactory
# ==============================================
resource "proxmox_virtual_environment_vm" "Satisfactory" {
  provider = proxmox.pve1
  name            = "Satisfactory"
  node_name       = "pve-1"
  scsi_hardware   = "virtio-scsi-single"
  started         = false
  tablet_device   = true
  tags            = []
  template        = false
  vm_id           = 106
  keyboard_layout = "en-us"
  migrate         = false
  on_boot         = true
  reboot          = false
  reboot_after_update = true
  stop_on_destroy = false
  timeout_clone        = 1800
  timeout_create       = 1800
  timeout_migrate      = 1800
  timeout_reboot       = 1800
  timeout_shutdown_vm  = 1800
  timeout_start_vm     = 1800
  timeout_stop_vm      = 300

  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = "virtio"
  }

  cpu {
    cores        = 4
    sockets      = 1
    type         = "host"
    numa         = true
    limit        = 0
    hotplugged   = 0
    units        = 1024
    flags        = []
    architecture = null
    affinity     = null
  }

  memory {
    dedicated      = 8192
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  disk {
    aio               = "io_uring"
    backup            = true
    cache             = "none"
    datastore_id      = "local-lvm"
    discard           = "ignore"
    file_format       = "raw"
    file_id           = null
    import_from       = null
    interface         = "scsi0"
    iothread          = true
    path_in_datastore = "vm-106-disk-0"
    replicate         = true
    serial            = null
    size              = 40
    ssd               = false
  }

  network_device {
    bridge      = "vmbr0"
    model       = "virtio"
    mac_address = "BC:24:11:BF:F5:9C"
    firewall    = true
    enabled     = true
    disconnected = false
    mtu         = 0
    queues      = 0
    rate_limit  = 0
    trunks      = null
    vlan_id     = 0
  }

  initialization {
    datastore_id         = "local-lvm"
    interface            = "ide0"
    meta_data_file_id    = null
    network_data_file_id = null
    type                 = null
    user_data_file_id    = null
    vendor_data_file_id  = null

    dns {
      domain  = "gwebs.ca"
      servers = ["192.168.10.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.10.14/24"
        gateway = "192.168.10.1"
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"
      ]
      password = null
    }
  }

  operating_system {
    type = "l26"
  }

  startup {
    order      = 10
    up_delay   = -1
    down_delay = -1
  }
}