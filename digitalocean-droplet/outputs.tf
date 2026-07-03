output "vm_name" {
  description = "Name of the created Droplet."
  value       = digitalocean_droplet.vm.name
}

output "droplet_id" {
  description = "DigitalOcean Droplet ID."
  value       = digitalocean_droplet.vm.id
}

output "host_ip_digitalocean_vm" {
  description = "Public IPv4 address registered in AWX inventory."
  value       = digitalocean_droplet.vm.ipv4_address
}
