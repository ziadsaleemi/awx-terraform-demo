output "vm_name" {
  description = "Name of the created Azure VM."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "vm_id" {
  description = "Azure resource ID."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  description = "Private IPv4 address."
  value       = azurerm_network_interface.vm.private_ip_address
}

output "public_ip_address" {
  description = "Public IPv4 address when assigned."
  value       = var.assign_public_ip ? azurerm_public_ip.vm[0].ip_address : ""
}

output "host_ip_azure_vm" {
  description = "Routable IP registered in AWX inventory."
  value       = var.assign_public_ip ? azurerm_public_ip.vm[0].ip_address : azurerm_network_interface.vm.private_ip_address
}
