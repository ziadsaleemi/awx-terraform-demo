output "vm_name" {
  description = "Name of the created OCI instance."
  value       = oci_core_instance.vm.display_name
}

output "instance_id" {
  description = "OCI instance OCID."
  value       = oci_core_instance.vm.id
}

output "private_ip_address" {
  description = "Private IPv4 address."
  value       = oci_core_instance.vm.private_ip
}

output "public_ip_address" {
  description = "Public IPv4 address when assigned."
  value       = oci_core_instance.vm.public_ip
}

output "host_ip_oci_vm" {
  description = "Routable IP registered in AWX inventory."
  value       = var.assign_public_ip ? oci_core_instance.vm.public_ip : oci_core_instance.vm.private_ip
}
