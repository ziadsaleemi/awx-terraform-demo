variable "vm_name" {
  description = "Name of the Azure VM."
  type        = string
  default     = "awx-demo-azure"
}

variable "resource_group_name" {
  description = "Existing Azure resource group."
  type        = string
}

variable "vnet_name" {
  description = "Existing Azure virtual network."
  type        = string
}

variable "subnet_name" {
  description = "Existing Azure subnet."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2ms"
}

variable "image_publisher" {
  description = "Marketplace image publisher."
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Marketplace image offer."
  type        = string
  default     = "ubuntu-24_04-lts"
}

variable "image_sku" {
  description = "Marketplace image SKU."
  type        = string
  default     = "server"
}

variable "image_version" {
  description = "Marketplace image version."
  type        = string
  default     = "latest"
}

variable "vm_image_id" {
  description = "Custom or gallery image ID. Leave empty to use the marketplace image fields."
  type        = string
  default     = ""
}

variable "os_disk_type" {
  description = "OS disk storage account type."
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB. Set to 0 for the image default."
  type        = number
  default     = 0
}

variable "admin_username" {
  description = "Admin username."
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password. Used only when ssh_public_key is empty."
  type        = string
  default     = ""
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key. When set, password authentication is disabled."
  type        = string
  default     = ""
}

variable "assign_public_ip" {
  description = "Create and assign a public IP."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to created resources."
  type        = map(string)
  default = {
    managed_by = "awx"
    demo       = "terraform"
  }
}
