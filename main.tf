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
resource "aws_instance" "Dev-mirror" {
  ami                    = var.rhel
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.Terraform_Dev-Servers.id]
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-Dev-mirror"
  }
}

resource "aws_instance" "Dev-Instance2" {

  ami = var.rhel
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Dev-Servers.id]
  source_dest_check      = false
  tags = {
    Name = "terraform-Dev-Instance2"
  }
	
  provisioner "local-exec" {
    command = "echo ${aws_instance.Dev-Instance2.public_ip} > ip_address.txt"
  }

}

resource "aws_instance" "Dev-Instance3" {

  ami = var.ubuntu
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Terraform_Dev-Servers.id]
  source_dest_check      = false

  tags = {
    Name = "terraform-Dev-Instance3"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.Dev-Instance3.public_ip} > ip_address.txt"
  }

}


resource "aws_instance" "Dev-Instance4" {

  ami = var.rhel
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_Dev.id]
  source_dest_check      = false
  tags = {
    Name = "terraform-Dev-Instance4"
  }
	
  provisioner "local-exec" {
    command = "echo ${aws_instance.Dev-Instance4.public_ip} > ip_address.txt"
  }

}

resource "aws_instance" "Dev-PwsLinux" {

  ami = var.suse
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_Dev.id]
  source_dest_check      = false
	
  tags = {
    Name = "terraform-Dev-PwsLinux"
  }
	
  provisioner "local-exec" {
    command = "echo ${aws_instance.Dev-PwsLinux.public_ip} > ip_address.txt"	
  }

}

# Create Security Group for EC2
resource "aws_security_group" "terraform_Dev" {
  name = "terraform-Dev-sg"

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

# Create Security Group for EC2_v2
resource "aws_security_group" "Terraform_Dev-Servers" {
  name = "terraform-Terraform_Dev-Servers-sg"

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
