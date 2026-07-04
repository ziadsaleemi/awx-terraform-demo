variable "vm_name" {
  description = "Name of the vSphere VM."
  type        = string
  default     = "awx-demo-vsphere"
}

variable "datacenter" {
  description = "vSphere datacenter name."
  type        = string
}

variable "cluster" {
  description = "vSphere compute cluster name."
  type        = string
}

variable "datastore" {
  description = "vSphere datastore name."
  type        = string
}

variable "network" {
  description = "vSphere network name."
  type        = string
}

variable "template_name" {
  description = "vSphere VM template name."
  type        = string
}

variable "vsphere_server" {
  description = "vSphere server. Leave null to use VSPHERE_SERVER from the AWX credential."
  type        = string
  default     = null
}

variable "vsphere_user" {
  description = "vSphere username. Leave null to use VSPHERE_USER from the AWX credential."
  type        = string
  default     = null
}

variable "vsphere_password" {
  description = "vSphere password. Leave null to use VSPHERE_PASSWORD from the AWX credential."
  type        = string
  default     = null
  sensitive   = true
}

variable "folder" {
  description = "Optional vSphere VM folder."
  type        = string
  default     = null
}

variable "cpu" {
  description = "vCPU count."
  type        = number
  default     = 2
}

variable "memory_mb" {
  description = "Memory in MiB."
  type        = number
  default     = 2048
}

variable "disk_gb" {
  description = "Disk size in GiB. Set to 0 to use the template disk size."
  type        = number
  default     = 0
}

variable "domain" {
  description = "Guest OS domain."
  type        = string
  default     = "localdomain"
}

variable "ip_address" {
  description = "Static IPv4 address. Leave empty to use DHCP."
  type        = string
  default     = ""
}

variable "ip_netmask" {
  description = "Netmask bits for static IPv4."
  type        = number
  default     = 24
}

variable "gateway" {
  description = "Gateway for static IPv4."
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "Guest DNS servers."
  type        = list(string)
  default     = []
}

variable "vsphere_allow_unverified_ssl" {
  description = "Disable vSphere TLS verification."
  type        = bool
  default     = true
}

variable "enable_cloud_init" {
  description = "Inject VMware guestinfo cloud-init data for AWX SSH bootstrap."
  type        = bool
  default     = true
}

variable "ssh_username" {
  description = "Guest user created by cloud-init for AWX configuration jobs."
  type        = string
  default     = "ansible"
}

variable "ssh_public_key" {
  description = "SSH public key authorized for ssh_username. Leave empty to skip guestinfo cloud-init bootstrap."
  type        = string
  default     = ""
}

variable "extra_config" {
  description = "Additional vSphere VMX extra_config values to merge with AWX cloud-init bootstrap settings."
  type        = map(string)
  default     = {}
}
