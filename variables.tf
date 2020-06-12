variable "instance_count" {
  default = 2
}

variable "key_name" {
  description = "Jenkins"
  default     = "Jenkins"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t3.small"
}

variable "ami" {
  description = "Base AMI to launch the instances"

  # change this to RHEL free tier
  default = "ami-07dfba995513840b5"
}

variable "region"{
	default = "eu-central-1"
}
