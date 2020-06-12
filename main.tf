# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-dev-gabor"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
	region = var.region 
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}

resource "aws_instance" "example" {

  ami = "ami-01a6e31ac994bbc09"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Examples.id]
  source_dest_check      = false
  tags = {
    Name = "terraform-Example1"
  }
	
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }

}

resource "aws_instance" "example2" {

  ami = "ami-01a6e31ac994bbc09"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Examples.id]
  source_dest_check      = false

  tags = {
    Name = "terraform-Example2"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.example2.public_ip} > ip_address.txt"
  }

}


resource "aws_instance" "example3" {

  ami = "ami-01a6e31ac994bbc09"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Examples.id]
  source_dest_check      = false
  tags = {
    Name = "terraform-Example3"
  }
	
  provisioner "local-exec" {
    command = "echo ${aws_instance.example3.public_ip} > ip_address.txt"
  }

}

resource "aws_instance" "PwsLinux" {

  ami = "ami-06b6dafd50fc45e21"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Examples.id]
  source_dest_check      = false
	
  tags = {
    Name = "terraform-PwsLinux"
  }
	
  provisioner "local-exec" {
    command = "echo ${aws_instance.PwsLinux.public_ip} > ip_address.txt"	
  }

}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Create Security Group for EC2_v2
resource "aws_security_group" "Terraform_Examples" {
  name = "terraform-Terraform_Examples-sg"

  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
	
  ingress {
    from_port   = 443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }	

}
