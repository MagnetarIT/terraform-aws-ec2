provider "aws" {
  region = "eu-west-2"
}

module "ec2" {
  source = "../"
  namespace = "mag"
  environment = "dev"
  name = "myapp"
  ssh_key_pair = "Lewis"
  security_groups = [module.sg.security_group_id]
  aws_cloudwatch_auto_reboot = true
  additional_cloudwatch_alarm_action = ""
}

module "sg" {
  source          = "git::https://github.com/MagnetarIT/terraform-aws-security-group.git?ref=tags/0.1.0"
  namespace       = "mag"
  environment     = "prod"
  name            = "myapp"
  sg_rules_cidr   = local.sg_rules_cidr
}

locals {
  sg_rules_cidr = [
    {
      type        = "ingress"
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
    },
  ]
}