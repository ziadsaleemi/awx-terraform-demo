output "vm_name" {
  description = "Name of the created vSphere VM."
  value       = vsphere_virtual_machine.vm.name
}

output "vm_id" {
  description = "vSphere VM ID."
  value       = vsphere_virtual_machine.vm.id
}

output "default_ip_address" {
  description = "Default IP address reported by VMware tools."
  value       = vsphere_virtual_machine.vm.default_ip_address
}

output "host_ip_vmware_vm" {
  description = "Routable IP registered in AWX inventory."
  value       = vsphere_virtual_machine.vm.default_ip_address != "" ? vsphere_virtual_machine.vm.default_ip_address : var.ip_address
}

output "ansible_user" {
  description = "Guest user intended for AWX configuration jobs."
  value       = var.ssh_username
}
