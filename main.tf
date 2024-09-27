terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


#Defining Security Groups

# Security Group A
resource "aws_security_group" "ping_a" {
  name        = "ping-a"
  description = "Security group for instance A"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# Security Group B
resource "aws_security_group" "ping_b" {
  name        = "ping-b"
  description = "Security group for instance B"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# Allow ICMP from PING-B to PING-A
resource "aws_security_group_rule" "allow_icmp_ping_b_to_ping_a" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.ping_a.id
  source_security_group_id = aws_security_group.ping_b.id
}

# Allow ICMP from PING-A to PING-B
resource "aws_security_group_rule" "allow_icmp_ping_a_to_ping_b" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.ping_b.id
  source_security_group_id = aws_security_group.ping_a.id
}


# EC2 Instances

variable "key_pair_name" {
  description = "Name of the AWS key pair"
  type        = string
}

resource "aws_instance" "instance_A" {
  ami             = "ami-04a81a99f5ec58529"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ping_a.name]
  key_name        = var.key_pair_name

  tags = {
    Name = "Instance A"
  }
}

resource "aws_instance" "instance_B" {
  ami             = "ami-04a81a99f5ec58529"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ping_b.name]
  key_name        = var.key_pair_name

  tags = {
    Name = "Instance B"
  }
}



