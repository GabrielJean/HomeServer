resource "proxmox_virtual_environment_vm" "this" {
  name             = var.name
  node_name        = var.node_name
  scsi_hardware    = var.scsi_hardware
  started          = var.started
  tablet_device    = var.tablet_device
  tags             = var.tags
  template         = var.template
  vm_id            = var.vm_id
  keyboard_layout  = var.keyboard_layout
  migrate          = var.migrate
  on_boot          = var.on_boot
  reboot           = var.reboot
  reboot_after_update = var.reboot_after_update
  stop_on_destroy  = var.stop_on_destroy
  timeout_clone        = var.timeout_clone
  timeout_create       = var.timeout_create
  timeout_migrate      = var.timeout_migrate
  timeout_reboot       = var.timeout_reboot
  timeout_shutdown_vm  = var.timeout_shutdown_vm
  timeout_start_vm     = var.timeout_start_vm
  timeout_stop_vm      = var.timeout_stop_vm

  agent {
    enabled = var.agent_enabled
    timeout = var.agent_timeout
    trim    = var.agent_trim
    type    = var.agent_type
  }

  cpu {
    cores        = var.cpu_cores
    sockets      = var.cpu_sockets
    type         = var.cpu_type
    numa         = var.cpu_numa
    limit        = var.cpu_limit
    hotplugged   = var.cpu_hotplugged
    units        = var.cpu_units
    flags        = var.cpu_flags
    architecture = var.cpu_architecture
    affinity     = var.cpu_affinity
  }

  memory {
    dedicated      = var.memory_dedicated
    floating       = var.memory_floating
    hugepages      = var.memory_hugepages
    keep_hugepages = var.memory_keep_hugepages
    shared         = var.memory_shared
  }

    dynamic "disk" {
      for_each = var.disks
      content {
        # Merge user disk with defaults
        # Only size and interface are required from user
        # All other fields defaulted
        # Use null coalescing for optional fields
        aio               = lookup(disk.value, "aio", "io_uring")
        backup            = lookup(disk.value, "backup", true)
        cache             = lookup(disk.value, "cache", "none")
        datastore_id      = lookup(disk.value, "datastore_id", var.init_datastore_id)
        discard           = lookup(disk.value, "discard", "ignore")
        file_format       = lookup(disk.value, "file_format", "raw")
        file_id           = lookup(disk.value, "file_id", null)
        import_from       = lookup(disk.value, "import_from", null)
        interface         = disk.value["interface"]
        iothread          = lookup(disk.value, "iothread", true)
        path_in_datastore = lookup(disk.value, "path_in_datastore", null)
        replicate         = lookup(disk.value, "replicate", true)
        serial            = lookup(disk.value, "serial", null)
        size              = disk.value["size"]
        ssd               = lookup(disk.value, "ssd", false)
      }
    }

  dynamic "network_device" {
    for_each = var.network_devices
    content {
      bridge      = network_device.value.bridge
      model       = network_device.value.model
      mac_address = network_device.value.mac_address
      firewall    = network_device.value.firewall
      enabled     = network_device.value.enabled
      disconnected = network_device.value.disconnected
      mtu         = network_device.value.mtu
      queues      = network_device.value.queues
      rate_limit  = network_device.value.rate_limit
      trunks      = network_device.value.trunks
      vlan_id     = network_device.value.vlan_id
    }
  }
    dynamic "network_device" {
      for_each = var.network_devices
      content {
        # Merge user network device with defaults
        # Only mac_address is required from user
        bridge      = lookup(network_device.value, "bridge", "vmbr0")
        model       = lookup(network_device.value, "model", "virtio")
        mac_address = network_device.value["mac_address"]
        firewall    = lookup(network_device.value, "firewall", true)
        enabled     = lookup(network_device.value, "enabled", true)
        disconnected = lookup(network_device.value, "disconnected", false)
        mtu         = lookup(network_device.value, "mtu", 0)
        queues      = lookup(network_device.value, "queues", 0)
        rate_limit  = lookup(network_device.value, "rate_limit", 0)
        trunks      = lookup(network_device.value, "trunks", null)
        vlan_id     = lookup(network_device.value, "vlan_id", 0)
      }
    }

  initialization {
    datastore_id         = var.init_datastore_id
    interface            = var.init_interface
    meta_data_file_id    = var.init_meta_data_file_id
    network_data_file_id = var.init_network_data_file_id
    type                 = var.init_type
    user_data_file_id    = var.init_user_data_file_id
    vendor_data_file_id  = var.init_vendor_data_file_id

    dns {
      domain  = var.init_dns_domain
      servers = var.init_dns_servers
    }

    ip_config {
      ipv4 {
        address = var.init_ipv4_address
        gateway = var.init_ipv4_gateway
      }
      ipv6 {
        address = var.init_ipv6_address
        gateway = var.init_ipv6_gateway
      }
    }

    user_account {
      username = var.init_user_username
      keys     = var.init_user_keys
      password = var.init_user_password
    }
  }

  operating_system {
    type = var.os_type
  }

  dynamic "startup" {
    for_each = var.startup != null ? [var.startup] : []
    content {
      order      = startup.value.order
      up_delay   = startup.value.up_delay
      down_delay = startup.value.down_delay
    }
  }

  dynamic "hostpci" {
    for_each = var.hostpcis
    content {
      device   = hostpci.value.device
      id       = hostpci.value.id
      mapping  = hostpci.value.mapping
      mdev     = hostpci.value.mdev
      pcie     = hostpci.value.pcie
      rom_file = hostpci.value.rom_file
      rombar   = hostpci.value.rombar
      xvga     = hostpci.value.xvga
    }
  }

  dynamic "usb" {
    for_each = var.usbs
    content {
      host    = usb.value.host
      mapping = usb.value.mapping
      usb3    = usb.value.usb3
    }
  }
}
