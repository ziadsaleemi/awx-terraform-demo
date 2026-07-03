variable "instance_name" {
  description = "Name of the GCP Compute Engine instance."
  type        = string
  default     = "awx-demo-gcp"
}

variable "gcp_project" {
  description = "GCP project ID. Leave empty to use GOOGLE_PROJECT from the AWX credential."
  type        = string
  default     = ""
}

variable "gcp_region" {
  description = "GCP region."
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "GCP zone."
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "GCP machine type."
  type        = string
  default     = "e2-micro"
}

variable "image" {
  description = "Boot image."
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB."
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "Boot disk type."
  type        = string
  default     = "pd-standard"
}

variable "network" {
  description = "VPC network name."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Subnetwork name. Leave empty for automatic selection."
  type        = string
  default     = ""
}

variable "assign_public_ip" {
  description = "Assign an ephemeral public IP."
  type        = bool
  default     = true
}

variable "create_firewall_rule" {
  description = "Create a demo SSH firewall rule."
  type        = bool
  default     = true
}

variable "ssh_source_ranges" {
  description = "CIDR ranges allowed to SSH to the instance."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "network_tag" {
  description = "Network tag used by the optional firewall rule."
  type        = string
  default     = "awx-ssh"
}

variable "ssh_user" {
  description = "SSH username for metadata injection."
  type        = string
  default     = "ansible"
}

variable "ssh_public_key" {
  description = "SSH public key to inject into instance metadata."
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to apply to the instance."
  type        = map(string)
  default = {
    managed_by = "awx"
    demo       = "terraform"
  }
}
