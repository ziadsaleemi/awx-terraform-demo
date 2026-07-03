variable "droplet_name" {
  description = "Name of the DigitalOcean Droplet."
  type        = string
  default     = "awx-demo-do"
}

variable "do_region" {
  description = "DigitalOcean region slug. AWX injects DO_REGION from the credential when configured."
  type        = string
  default     = "nyc3"
}

variable "do_droplet_size" {
  description = "DigitalOcean Droplet size slug."
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "do_image" {
  description = "DigitalOcean image slug or snapshot ID."
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "do_vpc_uuid" {
  description = "DigitalOcean VPC UUID. Leave empty to use the region default."
  type        = string
  default     = ""
}

variable "do_ssh_key_name" {
  description = "Name of an existing DigitalOcean SSH key."
  type        = string
  default     = ""
}

variable "do_ssh_key_ids" {
  description = "DigitalOcean SSH key IDs to attach when do_ssh_key_name is empty."
  type        = list(number)
  default     = []
}

variable "user_data" {
  description = "Cloud-init user-data."
  type        = string
  default     = ""
}

variable "tags" {
  description = "DigitalOcean tags."
  type        = list(string)
  default     = ["awx-managed", "terraform-demo"]
}
