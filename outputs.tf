output "public_ip" {
  description = "Public IP of instance (or EIP)"
  value       = join("", aws_instance.default.*.public_ip)
}

output "private_ip" {
  description = "Private IP of instance"
  value       = join("", aws_instance.default.*.private_ip)
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = join("", aws_instance.default.*.private_dns)
}

output "public_dns" {
  description = "Public DNS of instance (or DNS of EIP)"
  value       = local.public_dns
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = join("", aws_instance.default.*.id)
}

output "name" {
  description = "Instance name"
  value       = module.naming.id
}

output "ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = var.ssh_key_pair
}

output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value       = var.security_groups
}

output "role" {
  description = "Name of AWS IAM Role associated with the instance"
  value       = join("", aws_iam_role.default.*.name)
}

output "alarm" {
  description = "CloudWatch Alarm ID"
  value       = join("", aws_cloudwatch_metric_alarm.default.*.id)
}

output "ebs_ids" {
  description = "IDs of EBSs"
  value       = aws_ebs_volume.default.*.id
}

output "primary_network_interface_id" {
  description = "ID of the instance's primary network interface"
  value       = join("", aws_instance.default.*.primary_network_interface_id)
}

output "kms_key_id" {
  description = "Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Default to (aws_ebs_default_kms_key)"
  value       = local.kms_key_id
}

output "elastic_ip_public_ip" {
  description = "Contains the public IP address for the Elastic IP."
  value       = join("",aws_eip.default.*.public_ip)
}

output "elastic_ip_id" {
  description = "Contains the EIP allocation ID."
  value       = join("", aws_eip.default.*.id)
}