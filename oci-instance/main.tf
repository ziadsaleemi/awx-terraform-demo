terraform {
  required_version = ">= 1.5"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.0"
    }
  }
}

provider "oci" {}

resource "oci_core_instance" "vm" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = var.instance_name
  shape               = var.shape

  create_vnic_details {
    subnet_id        = var.subnet_ocid
    assign_public_ip = var.assign_public_ip
    display_name     = "${var.instance_name}-vnic"
    hostname_label   = var.hostname_label
  }

  source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

  metadata = var.ssh_public_key != "" ? {
    ssh_authorized_keys = var.ssh_public_key
  } : {}

  freeform_tags = var.tags
}
