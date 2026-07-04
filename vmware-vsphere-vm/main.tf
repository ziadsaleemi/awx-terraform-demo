terraform {
  required_version = ">= 1.5"

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.9"
    }
  }

  # Shared backend keeps state outside AWX's per-job working directory.
  # Authenticate with ARM_* env vars from an AWX Azure RM (Terraform) credential.
  backend "azurerm" {
    resource_group_name  = "rg-ziad-3557_ai"
    storage_account_name = "awxtfstate3557c3c"
    container_name       = "tfstate"
    key                  = "awx/terraform_demo/vmware-vsphere-vm.tfstate"
    use_azuread_auth     = true
  }
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

locals {
  ssh_public_key     = trimspace(var.ssh_public_key)
  cloud_init_enabled = var.enable_cloud_init && local.ssh_public_key != ""
  cloud_init_userdata = local.cloud_init_enabled ? "#cloud-config\n${yamlencode({
    users = [
      {
        name                = var.ssh_username
        groups              = "wheel"
        shell               = "/bin/bash"
        sudo                = "ALL=(ALL) NOPASSWD:ALL"
        lock_passwd         = true
        ssh_authorized_keys = [local.ssh_public_key]
      }
    ]
    ssh_pwauth = false
    runcmd = [
      "mkdir -p /tmp/ansible",
      "chmod 1777 /tmp/ansible",
    ]
  })}" : null
  cloud_init_metadata = local.cloud_init_enabled ? yamlencode({
    "instance-id"    = var.vm_name
    "local-hostname" = var.vm_name
  }) : null
  cloud_init_extra_config = local.cloud_init_enabled ? {
    "guestinfo.userdata"          = base64encode(local.cloud_init_userdata)
    "guestinfo.userdata.encoding" = "base64"
    "guestinfo.metadata"          = base64encode(local.cloud_init_metadata)
    "guestinfo.metadata.encoding" = "base64"
  } : {}
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.folder

  num_cpus = var.cpu
  memory   = var.memory_mb
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.disk_gb > 0 ? var.disk_gb : data.vsphere_virtual_machine.template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = var.domain
      }

      network_interface {
        ipv4_address = var.ip_address != "" ? var.ip_address : null
        ipv4_netmask = var.ip_address != "" ? var.ip_netmask : null
      }

      ipv4_gateway    = var.ip_address != "" ? var.gateway : null
      dns_server_list = var.dns_servers
    }
  }

  extra_config = merge(local.cloud_init_extra_config, var.extra_config)
}
