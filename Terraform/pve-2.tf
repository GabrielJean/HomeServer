resource "proxmox_virtual_environment_vm" "Docker-2" {
  provider         = proxmox.pve2
  name             = "Docker-2"
  node_name        = "pve-2"
  vm_id            = 101
  acpi             = true
  bios             = "seabios"
  protection       = false
  scsi_hardware    = "virtio-scsi-single"
  started          = true
  tablet_device    = true
  tags             = []
  template         = false

  cpu {
    cores        = 4
    sockets      = 1
    type         = "x86-64-v2-AES"
    numa         = true
    limit        = 0
    hotplugged   = 4
    units        = 1024
    flags        = []
    architecture = null
    affinity     = null
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
    path_in_datastore = "vm-101-disk-0"
    replicate         = true
    serial            = null
    size              = 30
    ssd               = false
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
      servers = ["192.168.15.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.15.11/24"
        gateway = "192.168.15.1"
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"]
      # password omitted for security
    }
  }

  memory {
    dedicated      = 5120
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  network_device {
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = true
    mac_address  = "BC:24:11:B7:B9:6B"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = null
    vlan_id      = 0
  }

  operating_system {
    type = "l26"
  }

  startup {
    down_delay = -1
    order      = 2
    up_delay   = -1
  }

  usb {
    host    = "10c4:ea60"
    mapping = null
    usb3    = false
  }
}

resource "proxmox_virtual_environment_vm" "DNS-2" {
  provider         = proxmox.pve2
  name             = "DNS-2"
  node_name        = "pve-2"
  vm_id            = 102
  acpi             = true
  bios             = "seabios"
  protection       = false
  scsi_hardware    = "virtio-scsi-single"
  started          = true
  tablet_device    = true
  tags             = []
  template         = false

  agent {
    enabled = true
    timeout = "15m"
    trim    = false
    type    = null
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
      servers = ["192.168.15.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.15.5/24"
        gateway = "192.168.15.1"
      }
      ipv6 {
        address = "dhcp"
        gateway = null
      }
    }

    user_account {
      username = "gabriel"
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"]
      # password omitted for security
    }
  }

  memory {
    dedicated      = 2048
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  network_device {
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = true
    mac_address  = "BC:24:11:FF:0E:85"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = null
    vlan_id      = 0
  }

  operating_system {
    type = "l26"
  }

  startup {
    down_delay = -1
    order      = 1
    up_delay   = -1
  }
}

resource "proxmox_virtual_environment_vm" "Ubuntu-Cloud-2" {
  provider         = proxmox.pve2
  name             = "Ubuntu-Cloud-2"
  node_name        = "pve-2"
  vm_id            = 100
  acpi             = true
  bios             = "seabios"
  protection       = false
  scsi_hardware    = "virtio-scsi-single"
  started          = false
  tablet_device    = true
  tags             = []
  template         = true

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
    path_in_datastore = "base-100-disk-0"
    replicate         = true
    serial            = null
    size              = 50
    ssd               = false
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
      servers = ["192.168.15.1"]
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
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDpRej6BHMw/6qH5zmyzE4mI6skbjSowAeqUPBpOP8sR gabri@Gwebs-PC-1"]
      # password omitted for security
    }
  }

  memory {
    dedicated      = 3072
    floating       = 0
    hugepages      = null
    keep_hugepages = false
    shared         = 0
  }

  network_device {
    bridge       = "vmbr0"
    disconnected = false
    enabled      = true
    firewall     = true
    mac_address  = "BC:24:11:36:FC:31"
    model        = "virtio"
    mtu          = 0
    queues       = 0
    rate_limit   = 0
    trunks       = null
    vlan_id      = 0
  }

  operating_system {
    type = "l26"
  }
}