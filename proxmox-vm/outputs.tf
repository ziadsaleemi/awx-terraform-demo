locals {
  all_ipv4    = try(proxmox_virtual_environment_vm.vm.ipv4_addresses, [])
  raw_ips     = flatten([for iface_ips in local.all_ipv4 : [for ip in iface_ips : trimspace(tostring(ip))]])
  usable_ips  = [for ip in local.raw_ips : ip if ip != "127.0.0.1" && ip != "" && !startswith(ip, "169.254.")]
  resolved_ip = length(local.usable_ips) > 0 ? local.usable_ips[0] : var.ip_address
}

output "vm_name" {
  description = "Name of the created Proxmox VM."
  value       = proxmox_virtual_environment_vm.vm.name
}

output "vm_id" {
  description = "Proxmox VM ID."
  value       = proxmox_virtual_environment_vm.vm.vm_id
}

output "cloud_init_user" {
  description = "Cloud-init user configured on the VM."
  value       = var.cloud_init_user
}

output "host_ip_proxmox_vm" {
  description = "Routable IP registered in AWX inventory."
  value       = local.resolved_ip
}
