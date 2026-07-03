terraform {
  required_version = ">= 1.5"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.69"
    }
  }
}

provider "proxmox" {
  endpoint  = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  insecure  = var.pm_tls_insecure
}

locals {
  node = var.pm_node != "" ? var.pm_node : var.proxmox_node
}

data "proxmox_virtual_environment_vms" "template" {
  node_name = local.node

  filter {
    name   = "name"
    values = [var.proxmox_template_name]
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.vm_name
  node_name = local.node

  clone {
    vm_id     = data.proxmox_virtual_environment_vms.template.vms[0].vm_id
    node_name = local.node
    full      = true
  }

  agent {
    enabled = true
    timeout = "10m"
  }

  cpu {
    cores = var.cores
    type  = "host"
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.storage_pool
    size         = var.disk_gb
    interface    = "scsi0"
    file_format  = var.disk_file_format
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address != "" ? "${var.ip_address}/${var.ip_prefix_length}" : "dhcp"
        gateway = var.ip_address != "" ? var.gateway : null
      }
    }

    user_account {
      username = var.cloud_init_user
      password = var.cloud_init_password != "" ? var.cloud_init_password : null
      keys     = var.ssh_public_key != "" ? [var.ssh_public_key] : []
    }
  }
}
