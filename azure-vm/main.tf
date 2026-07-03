terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "vm" {
  count               = var.assign_public_ip ? 1 : 0
  name                = "${var.vm_name}-pip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "vm" {
  name                = "${var.vm_name}-nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.assign_public_ip ? azurerm_public_ip.vm[0].id : null
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.ssh_public_key == "" ? var.admin_password : null
  disable_password_authentication = var.ssh_public_key != ""
  network_interface_ids           = [azurerm_network_interface.vm.id]

  dynamic "admin_ssh_key" {
    for_each = var.ssh_public_key != "" ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.ssh_public_key
    }
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb > 0 ? var.os_disk_size_gb : null
  }

  dynamic "source_image_reference" {
    for_each = var.vm_image_id == "" ? [1] : []
    content {
      publisher = var.image_publisher
      offer     = var.image_offer
      sku       = var.image_sku
      version   = var.image_version
    }
  }

  source_image_id = var.vm_image_id != "" ? var.vm_image_id : null
  tags            = var.tags
}
