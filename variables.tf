variable "namespace" {
  type        = string
  description = "Namespace, which could be your team, business name or abbreviation, e.g. 'mag' or 'tar'"
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "custom_aws_iam_role_policy" {
  type        = string
  default     = ""
  description = "Json formatted IAM role policy for the instance profile, use `data.aws_iam_policy_document.xxx.json`"
}

variable "permissions_boundary_arn" {
  type        = string
  description = "Policy ARN to attach to instance role as a permissions boundary"
  default     = ""
}

variable "subnet" {
  type        = string
  default     = ""
  description = "VPC Subnet ID the instance is launched in"
}

variable "default_availability_zone" {
  type        = string
  default     = "eu-west-2a"
  description = "Default availability zone used for subnet searching"
}

variable "ami" {
  type        = string
  description = "The AMI to use for the instance. By default it is the AMI provided by Amazon with Ubuntu 16.04"
  default     = ""
}

variable "ami_owner" {
  type        = string
  description = "Owner of the given AMI (ignored if `ami` unset)"
  default     = ""
}

variable "cpu_credits" {
  description = "The credit option for CPU usage (unlimited or standard)"
  type        = string
  default     = "standard"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}

variable "ebs_optimized" {
  type        = bool
  description = "Launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable_api_termination" {
  type        = bool
  description = "Enable EC2 Instance Termination Protection"
  default     = false
}

variable "monitoring" {
  type        = bool
  description = "Launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "user_data" {
  type        = string
  description = "Instance user data. Do not pass gzip-compressed data via this argument"
  default     = ""
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = true
}

variable "ssh_key_pair" {
  type        = string
  description = "SSH key pair to be provisioned on the instance"
}

variable "private_ip" {
  type        = string
  description = "Private IP address to associate with the instance in the VPC"
  default     = ""
}

variable "source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs"
  default     = true
}

variable "ipv6_address_count" {
  type        = number
  description = "Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet (-1 to use subnet default)"
  default     = 0
}

variable "ipv6_addresses" {
  type        = list(string)
  description = "List of IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}

variable "security_groups" {
  description = "List of Security Group IDs allowed to connect to the instance"
  type        = list(string)
  default     = []
}

variable "root_volume_type" {
  type        = string
  description = "Type of root volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume in gigabytes"
  default     = 10
}

variable "root_iops" {
  type        = number
  description = "Amount of provisioned IOPS. This must be set if root_volume_type is set to `io1`"
  default     = 0
}

variable "ebs_device_name" {
  type        = list(string)
  description = "Name of the EBS device to mount"
  default     = ["/dev/xvdb", "/dev/xvdc", "/dev/xvdd", "/dev/xvde", "/dev/xvdf", "/dev/xvdg", "/dev/xvdh", "/dev/xvdi", "/dev/xvdj", "/dev/xvdk", "/dev/xvdl", "/dev/xvdm", "/dev/xvdn", "/dev/xvdo", "/dev/xvdp", "/dev/xvdq", "/dev/xvdr", "/dev/xvds", "/dev/xvdt", "/dev/xvdu", "/dev/xvdv", "/dev/xvdw", "/dev/xvdx", "/dev/xvdy", "/dev/xvdz"]
}

variable "ebs_volume_type" {
  type        = string
  description = "The type of EBS volume. Can be standard, gp2 or io1"
  default     = "gp2"
}

variable "ebs_volume_size" {
  type        = number
  description = "Size of the EBS volume in gigabytes"
  default     = 10
}

variable "ebs_iops" {
  type        = number
  description = "Amount of provisioned IOPS. This must be set with a volume_type of io1"
  default     = 0
}

variable "ebs_volume_count" {
  type        = number
  description = "Count of EBS volumes that will be attached to the instance"
  default     = 0
}

variable "delete_on_termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination"
  default     = true
}

variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. Possible values are: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "metric_name" {
  type        = string
  description = "The name for the alarm's associated metric. Allowed values can be found in https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ec2-metricscollected.html"
  default     = "StatusCheckFailed_Instance"
}

variable "evaluation_periods" {
  type        = number
  description = "The number of periods over which data is compared to the specified threshold."
  default     = 5
}

variable "metric_namespace" {
  type        = string
  description = "The namespace for the alarm's associated metric. Allowed values can be found in https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-namespaces.html"
  default     = "AWS/EC2"
}

variable "applying_period" {
  type        = number
  description = "The period in seconds over which the specified statistic is applied"
  default     = 60
}

variable "statistic_level" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric. Allowed values are: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Maximum"
}

variable "metric_threshold" {
  type        = number
  description = "The value against which the specified statistic is compared"
  default     = 1
}

variable "default_alarm_action" {
  type        = string
  default     = "action/actions/AWS_EC2.InstanceId.Reboot/1.0"
  description = "Default alarm action"
}

variable "aws_cloudwatch_auto_reboot" {
  type        = bool
  default     = false
  description = "Enable the cloudwatch auto reboot alarm"
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "Amazon Resource Name (ARN) of the KMS Key to use when encrypting the volume. Default to (aws_ebs_default_kms_key)"
}

variable "additional_cloudwatch_alarm_action" {
  type        = string
  default     = ""
  description = "Additional cloudwatch alarm action arn to trigger if instance fails status checks."
}
