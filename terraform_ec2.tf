terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1" # Mumbai Region
}

# Required Security Group to open ports for SSH and Jenkins UI
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg-only"
  description = "Allows SSH and Jenkins access"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# EC2 Instance Configurations
resource "aws_instance" "jenkins_server" {
  ami               = "ami-0522ab6e1ddcc7055" # Ubuntu 22.04 LTS in Mumbai
  instance_type     = "t2.micro"             # Free Tier eligible
  availability_zone = "ap-south-1a"          

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = "jenkins-key" # Your newly created key pair name

  tags = {
    Name = "Jenkins-Server"
  }
}

# Prints out the IP in the terminal automatically when execution finishes
output "jenkins_public_ip" {
  value       = aws_instance.jenkins_server.public_ip
  description = "The public IP address of your Jenkins instance"
}

