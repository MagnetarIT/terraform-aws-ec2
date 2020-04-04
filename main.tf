module "naming" {
  source      = "git::https://github.com/MagnetarIT/terraform-naming-standard.git?ref=tags/0.1.0"
  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  attributes  = var.attributes
  tags        = var.tags
}

locals {
  region             = data.aws_region.default.name
  root_iops          = var.root_volume_type == "io1" ? var.root_iops : "0"
  ebs_iops           = var.ebs_volume_type == "io1" ? var.ebs_iops : "0"
  ami                = var.ami != "" ? var.ami : join("", data.aws_ami.default.*.image_id)
  ami_owner          = var.ami != "" ? var.ami_owner : join("", data.aws_ami.default.*.owner_id)
  root_volume_type   = var.root_volume_type != "" ? var.root_volume_type : data.aws_ami.info.root_device_type
  public_dns         = var.associate_public_ip_address ? join("", aws_instance.default.*.public_dns) : ""
  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a){1}\\..*$/", "1") == "1" ? true : false
}

data "aws_caller_identity" "default" {
}

data "aws_region" "default" {
}

data "aws_partition" "default" {
}

data "aws_subnet" "default" {
  id                = var.subnet
  availability_zone = var.subnet == "" ? var.default_availability_zone : ""
}

data "aws_ami" "default" {
  count       = var.ami == "" ? 1 : 0
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "info" {
  filter {
    name   = "image-id"
    values = [local.ami]
  }

  owners = [local.ami_owner]
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_instance_profile" "default" {
  name = module.naming.id
  role = join("", aws_iam_role.default.*.name)
}

resource "aws_iam_role" "default" {
  name                 = module.naming.id
  path                 = "/"
  assume_role_policy   = data.aws_iam_policy_document.default.json
  permissions_boundary = var.permissions_boundary_arn
}

resource "aws_iam_role_policy" "custom" {
  count  = var.custom_aws_iam_role_policy != "" ? 1 : 0
  name   = module.naming.id
  role   = aws_iam_role.default.id
  policy = var.custom_aws_iam_role_policy
}

resource "aws_instance" "default" {
  ami                         = local.ami
  instance_type               = var.instance_type
  ebs_optimized               = var.ebs_optimized
  disable_api_termination     = var.disable_api_termination
  user_data                   = var.user_data
  iam_instance_profile        = join("", aws_iam_instance_profile.default.*.name)
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.ssh_key_pair
  subnet_id                   = var.subnet
  monitoring                  = var.monitoring
  private_ip                  = var.private_ip
  source_dest_check           = var.source_dest_check
  ipv6_address_count          = var.ipv6_address_count < 0 ? null : var.ipv6_address_count
  ipv6_addresses              = length(var.ipv6_addresses) == 0 ? null : var.ipv6_addresses
  vpc_security_group_ids      = var.security_groups

  root_block_device {
    volume_type           = local.root_volume_type
    volume_size           = var.root_volume_size
    iops                  = local.root_iops
    delete_on_termination = var.delete_on_termination
  }

  credit_specification {
    cpu_credits = local.is_t_instance_type ? var.cpu_credits : null
  }

  tags = module.naming.tags

}

resource "aws_ebs_volume" "default" {
  count             = var.ebs_volume_count
  availability_zone = data.aws_subnet.default.availability_zone
  size              = var.ebs_volume_size
  iops              = local.ebs_iops
  type              = var.ebs_volume_type
  tags              = module.naming.tags
}

resource "aws_volume_attachment" "default" {
  count       = var.ebs_volume_count
  device_name = var.ebs_device_name[count.index]
  volume_id   = aws_ebs_volume.default.*.id[count.index]
  instance_id = join("", aws_instance.default.*.id)
}

resource "null_resource" "check_alarm_action" {
  count = var.aws_cloudwatch_auto_reboot ? 1 : 0

  triggers = {
    action = "arn:${data.aws_partition.default.partition}:swf:${local.region}:${data.aws_caller_identity.default.account_id}:${var.default_alarm_action}"
  }
}

resource "aws_cloudwatch_metric_alarm" "default" {
  count               = var.aws_cloudwatch_auto_reboot ? 1 : 0
  alarm_name          = module.naming.id
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.metric_namespace
  period              = var.applying_period
  statistic           = var.statistic_level
  threshold           = var.metric_threshold
  depends_on          = [null_resource.check_alarm_action]

  dimensions = {
    InstanceId = join("", aws_instance.default.*.id)
  }

  alarm_actions = [
    null_resource.check_alarm_action[count.index].triggers.action
  ]
}