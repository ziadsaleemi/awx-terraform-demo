output "vm_name" {
  description = "Name of the created EC2 instance."
  value       = aws_instance.vm.tags["Name"]
}

output "instance_id" {
  description = "AWS instance ID."
  value       = aws_instance.vm.id
}

output "private_ip_address" {
  description = "Private IPv4 address."
  value       = aws_instance.vm.private_ip
}

output "public_ip_address" {
  description = "Public IPv4 address when assigned."
  value       = aws_instance.vm.public_ip
}

output "host_ip_aws_vm" {
  description = "Routable IP registered in AWX inventory."
  value       = var.assign_public_ip ? aws_instance.vm.public_ip : aws_instance.vm.private_ip
}
