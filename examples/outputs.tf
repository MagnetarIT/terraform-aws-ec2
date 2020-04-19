output "public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = module.ec2.public_ip
}

output "private_ip" {
  description = "Private IP of instance"
  value       = module.ec2.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.ec2.private_dns
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = module.ec2.public_dns
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = module.ec2.id
}

output "name" {
  description = "Instance name"
  value       = module.ec2.name
}

output "ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = module.ec2.ssh_key_pair
}

output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value = module.ec2.security_group_ids
}

output "role" {
  description = "Name of AWS IAM Role associated with the instance"
  value       = module.ec2.role
}
  
output "alarm" {
  description = "CloudWatch Alarm ID"
  value       = module.ec2.alarm
}

output "ebs_ids" {
  description = "IDs of EBSs"
  value       = module.ec2.ebs_ids
}

output "primary_network_interface_id" {
  description = "ID of the instance's primary network interface"
  value       = module.ec2.primary_network_interface_id
}

output "kms_key_id" {
  description = "Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Default to (aws_ebs_default_kms_key)"
  value       = module.ec2.kms_key_id
}