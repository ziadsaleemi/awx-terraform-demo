variable "instance_name" {
  description = "Display name of the OCI instance."
  type        = string
  default     = "awx-demo-oci"
}

variable "compartment_ocid" {
  description = "OCI compartment OCID."
  type        = string
}

variable "availability_domain" {
  description = "OCI availability domain, for example abcD:US-ASHBURN-AD-1."
  type        = string
}

variable "subnet_ocid" {
  description = "Existing OCI subnet OCID."
  type        = string
}

variable "image_ocid" {
  description = "OCI image OCID."
  type        = string
}

variable "shape" {
  description = "OCI instance shape."
  type        = string
  default     = "VM.Standard.E2.1.Micro"
}

variable "assign_public_ip" {
  description = "Assign a public IP address."
  type        = bool
  default     = true
}

variable "hostname_label" {
  description = "Hostname label for the VNIC."
  type        = string
  default     = "awxdemooci"
}

variable "ssh_public_key" {
  description = "SSH public key to inject."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Freeform tags."
  type        = map(string)
  default = {
    managed_by = "awx"
    demo       = "terraform"
  }
}
