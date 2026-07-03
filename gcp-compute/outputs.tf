output "vm_name" {
  description = "Name of the created GCP instance."
  value       = google_compute_instance.vm.name
}

output "instance_id" {
  description = "GCP instance self link."
  value       = google_compute_instance.vm.self_link
}

output "private_ip_address" {
  description = "Private IPv4 address."
  value       = google_compute_instance.vm.network_interface[0].network_ip
}

output "public_ip_address" {
  description = "Public IPv4 address when assigned."
  value       = var.assign_public_ip ? google_compute_instance.vm.network_interface[0].access_config[0].nat_ip : ""
}

output "host_ip_gcp_vm" {
  description = "Routable IP registered in AWX inventory."
  value       = var.assign_public_ip ? google_compute_instance.vm.network_interface[0].access_config[0].nat_ip : google_compute_instance.vm.network_interface[0].network_ip
}
