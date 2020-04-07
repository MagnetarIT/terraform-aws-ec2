<a href=https://magnetarconsulting.co.uk><img src="https://magnetarconsulting.co.uk/wp-content/uploads/2020/04/small-helping-you-innovate-magnetar.png" width="300"></a>

# terraform-aws-ec2
Terraform (>= 0.12.0) module to create an EC2

[![Build Status](https://dev.azure.com/MagnetarIT/terraform-aws-ec2/_apis/build/status/MagnetarIT.terraform-aws-ec2?branchName=master)](https://dev.azure.com/MagnetarIT/terraform-aws-ec2/_build/latest?definitionId=14&branchName=master)

- [Intro](#Intro)
- [Example](#Example)
- [Inputs](#Inputs)
- [Outputs](#Outputs)
- [Support](#Support)
- [License](#License)

----

## Example
```hcl

provider "aws" {
  region = "eu-west-2"
}

module "ec2" {
  source       = "git::https://github.com/MagnetarIT/terraform-aws-ec2.git?ref=tags/0.1.0"
  namespace    = "mag"
  environment  = "dev"
  name         = "myapp"
  ssh_key_pair = "Lewis"
}

```

----

## Intro
This module will create the following resources
- EC2 Instance
- Cloudwatch auto reboot alarm (Optional)

---

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| null | ~> 2.0 |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | The AMI to use for the instance. By default it is the AMI provided by Amazon with Ubuntu 16.04 | `string` | `""` | no |
| ami\_owner | Owner of the given AMI (ignored if `ami` unset) | `string` | `""` | no |
| applying\_period | The period in seconds over which the specified statistic is applied | `number` | `60` | no |
| associate\_public\_ip\_address | Associate a public IP address with the instance | `bool` | `true` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| aws\_cloudwatch\_auto\_reboot | Enable the cloudwatch auto reboot alarm | `bool` | `false` | no |
| comparison\_operator | The arithmetic operation to use when comparing the specified Statistic and Threshold. Possible values are: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| cpu\_credits | The credit option for CPU usage (unlimited or standard) | `string` | `"standard"` | no |
| custom\_aws\_iam\_role\_policy | Json formatted IAM role policy for the instance profile, use `data.aws_iam_policy_document.xxx.json` | `string` | `""` | no |
| default\_alarm\_action | Default alarm action | `string` | `"action/actions/AWS_EC2.InstanceId.Reboot/1.0"` | no |
| default\_availability\_zone | Default availability zone used for subnet searching | `string` | `"eu-west-2a"` | no |
| delete\_on\_termination | Whether the volume should be destroyed on instance termination | `bool` | `true` | no |
| disable\_api\_termination | Enable EC2 Instance Termination Protection | `bool` | `false` | no |
| ebs\_device\_name | Name of the EBS device to mount | `list(string)` | <pre>[<br>  "/dev/xvdb",<br>  "/dev/xvdc",<br>  "/dev/xvdd",<br>  "/dev/xvde",<br>  "/dev/xvdf",<br>  "/dev/xvdg",<br>  "/dev/xvdh",<br>  "/dev/xvdi",<br>  "/dev/xvdj",<br>  "/dev/xvdk",<br>  "/dev/xvdl",<br>  "/dev/xvdm",<br>  "/dev/xvdn",<br>  "/dev/xvdo",<br>  "/dev/xvdp",<br>  "/dev/xvdq",<br>  "/dev/xvdr",<br>  "/dev/xvds",<br>  "/dev/xvdt",<br>  "/dev/xvdu",<br>  "/dev/xvdv",<br>  "/dev/xvdw",<br>  "/dev/xvdx",<br>  "/dev/xvdy",<br>  "/dev/xvdz"<br>]</pre> | no |
| ebs\_iops | Amount of provisioned IOPS. This must be set with a volume\_type of io1 | `number` | `0` | no |
| ebs\_optimized | Launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| ebs\_volume\_count | Count of EBS volumes that will be attached to the instance | `number` | `0` | no |
| ebs\_volume\_size | Size of the EBS volume in gigabytes | `number` | `10` | no |
| ebs\_volume\_type | The type of EBS volume. Can be standard, gp2 or io1 | `string` | `"gp2"` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | n/a | yes |
| evaluation\_periods | The number of periods over which data is compared to the specified threshold. | `number` | `5` | no |
| instance\_type | The type of the instance | `string` | `"t2.micro"` | no |
| ipv6\_address\_count | Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet (-1 to use subnet default) | `number` | `0` | no |
| ipv6\_addresses | List of IPv6 addresses from the range of the subnet to associate with the primary network interface | `list(string)` | `[]` | no |
| metric\_name | The name for the alarm's associated metric. Allowed values can be found in https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ec2-metricscollected.html | `string` | `"StatusCheckFailed_Instance"` | no |
| metric\_namespace | The namespace for the alarm's associated metric. Allowed values can be found in https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-namespaces.html | `string` | `"AWS/EC2"` | no |
| metric\_threshold | The value against which the specified statistic is compared | `number` | `1` | no |
| monitoring | Launched EC2 instance will have detailed monitoring enabled | `bool` | `true` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | n/a | yes |
| namespace | Namespace, which could be your team, business name or abbreviation, e.g. 'mag' or 'tar' | `string` | n/a | yes |
| permissions\_boundary\_arn | Policy ARN to attach to instance role as a permissions boundary | `string` | `""` | no |
| private\_ip | Private IP address to associate with the instance in the VPC | `string` | `""` | no |
| root\_iops | Amount of provisioned IOPS. This must be set if root\_volume\_type is set to `io1` | `number` | `0` | no |
| root\_volume\_size | Size of the root volume in gigabytes | `number` | `10` | no |
| root\_volume\_type | Type of root volume. Can be standard, gp2 or io1 | `string` | `"gp2"` | no |
| security\_groups | List of Security Group IDs allowed to connect to the instance | `list(string)` | `[]` | no |
| source\_dest\_check | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs | `bool` | `true` | no |
| ssh\_key\_pair | SSH key pair to be provisioned on the instance | `string` | n/a | yes |
| statistic\_level | The statistic to apply to the alarm's associated metric. Allowed values are: SampleCount, Average, Sum, Minimum, Maximum | `string` | `"Maximum"` | no |
| subnet | VPC Subnet ID the instance is launched in | `string` | `""` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| user\_data | Instance user data. Do not pass gzip-compressed data via this argument | `string` | `""` | no |

---

## Outputs

| Name | Description |
|------|-------------|
| alarm | CloudWatch Alarm ID |
| ebs\_ids | IDs of EBSs |
| id | Disambiguated ID of the instance |
| name | Instance name |
| primary\_network\_interface\_id | ID of the instance's primary network interface |
| private\_dns | Private DNS of instance |
| private\_ip | Private IP of instance |
| public\_dns | Public DNS of instance (or DNS of EIP) |
| public\_ip | Public IP of instance (or EIP) |
| role | Name of AWS IAM Role associated with the instance |
| security\_group\_ids | IDs on the AWS Security Groups associated with the instance |
| ssh\_key\_pair | Name of the SSH key pair provisioned on the instance |

---

## Support

Reach out to me at one of the following places!

- Website at <a href="https://magnetarconsulting.co.uk" target="_blank">`magnetarconsulting.co.uk`</a>
- Twitter at <a href="https://twitter.com/magnetarIT" target="_blank">`@magnetarIT`</a>
- LinkedIn at <a href="https://www.linkedin.com/company/magnetar-it-consulting" target="_blank">`magnetar-it-consulting`</a>

---

## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.