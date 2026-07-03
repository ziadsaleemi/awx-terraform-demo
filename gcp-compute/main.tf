terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project != "" ? var.gcp_project : null
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_compute_firewall" "ssh" {
  count   = var.create_firewall_rule ? 1 : 0
  name    = "${var.instance_name}-ssh"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = [var.network_tag]
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = [var.network_tag]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork != "" ? var.subnetwork : null

    dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {}
    }
  }

  metadata = var.ssh_public_key != "" ? {
    "ssh-keys" = "${var.ssh_user}:${var.ssh_public_key}"
  } : {}

  labels = var.labels

  depends_on = [google_compute_firewall.ssh]
}
