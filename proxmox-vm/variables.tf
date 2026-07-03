variable "vm_name" {
  description = "Name of the Proxmox VM."
  type        = string
  default     = "awx-demo-proxmox"
}

variable "proxmox_template_name" {
  description = "Cloud-init-enabled Proxmox template VM name."
  type        = string
}

variable "proxmox_node" {
  description = "Fallback Proxmox node when PM_NODE is not injected."
  type        = string
  default     = "pve"
}

variable "cores" {
  description = "vCPU cores."
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory in MiB."
  type        = number
  default     = 2048
}

variable "disk_gb" {
  description = "Disk size in GiB."
  type        = number
  default     = 20
}

variable "storage_pool" {
  description = "Proxmox datastore ID."
  type        = string
  default     = "local-lvm"
}

variable "disk_file_format" {
  description = "Proxmox disk file format."
  type        = string
  default     = "raw"
}

variable "network_bridge" {
  description = "Proxmox network bridge."
  type        = string
  default     = "vmbr0"
}

variable "ip_address" {
  description = "Static IPv4 address without prefix. Leave empty for DHCP."
  type        = string
  default     = ""
}

variable "ip_prefix_length" {
  description = "CIDR prefix length for static IPv4."
  type        = number
  default     = 24
}

variable "gateway" {
  description = "Gateway for static IPv4."
  type        = string
  default     = ""
}

variable "cloud_init_user" {
  description = "Cloud-init username."
  type        = string
  default     = "ansible"
}

variable "cloud_init_password" {
  description = "Cloud-init password. Leave empty to rely on SSH keys."
  type        = string
  default     = ""
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key to inject."
  type        = string
  default     = ""
  sensitive   = true
}

variable "pm_api_url" {
  description = "Proxmox API URL injected by AWX as TF_VAR_pm_api_url."
  type        = string
  default     = ""
}

variable "pm_api_token_id" {
  description = "Proxmox API token ID injected by AWX as TF_VAR_pm_api_token_id."
  type        = string
  default     = ""
}

variable "pm_api_token_secret" {
  description = "Proxmox API token secret injected by AWX as TF_VAR_pm_api_token_secret."
  type        = string
  default     = ""
  sensitive   = true
}

variable "pm_node" {
  description = "Proxmox node injected by AWX as TF_VAR_pm_node."
  type        = string
  default     = ""
}

variable "pm_tls_insecure" {
  description = "Disable Proxmox TLS verification."
  type        = bool
  default     = false
}
