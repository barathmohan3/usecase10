variable "vpc_id" {}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs in different Availability Zones"
}

variable "ec2_id" {}

variable "security_group_id" {}