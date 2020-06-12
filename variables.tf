variable "instance_count" {
  default = 2
}

variable "key_name" {
  description = "Dev_Test_Only"
  default     = "AWS_Terraform_default"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t3.small"
}

variable "rhel" {
  description = "Base AMI to launch the instances"

  # change this to RHEL free tier
  default = "ami-07dfba995513840b5"
}

variable "suse" {
  description = "Base AMI to launch the instances"

  # change this to RHEL free tier
  default = "ami-0d63f0d5c7bc514dd"
}

variable "ubuntu" {
  description = "Base AMI to launch the instances"

  # change this to RHEL free tier
  default = "ami-0d63f0d5c7bc514dd"
}

variable "region"{
	default = "eu-central-1"
}
