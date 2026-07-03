terraform {
  required_version = ">= 1.5"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {}

data "digitalocean_ssh_key" "key" {
  count = var.do_ssh_key_name != "" ? 1 : 0
  name  = var.do_ssh_key_name
}

resource "digitalocean_droplet" "vm" {
  name      = var.droplet_name
  region    = var.do_region
  size      = var.do_droplet_size
  image     = var.do_image
  ssh_keys  = var.do_ssh_key_name != "" ? [data.digitalocean_ssh_key.key[0].id] : var.do_ssh_key_ids
  vpc_uuid  = var.do_vpc_uuid != "" ? var.do_vpc_uuid : null
  user_data = var.user_data != "" ? var.user_data : null
  tags      = var.tags
}
