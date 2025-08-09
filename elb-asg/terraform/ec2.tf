locals {
  instances_names = ["EC2-A", "EC2-B"]
}

data "aws_vpc" "default-vpc" {
  default = true
}

/* data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "print-vpc" {
  value = data.aws_vpc.default-vpc.id
}*/

resource "aws_security_group" "sg-ec2" {
  name        = "ec2-instances-sg-group"
  description = "Security groups for the EC2 instances that will be connected to the ALB"
  vpc_id      = data.aws_vpc.default-vpc.id

  tags = {
    Name = "Security groups for the EC2 instances"
  }
} 

resource "aws_vpc_security_group_ingress_rule" "allow-connection-to-the-ALB-SG" {
  security_group_id            = aws_security_group.sg-ec2.id
  referenced_security_group_id = aws_security_group.alb-sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "outbound-egress-ec2" {
  security_group_id = aws_security_group.sg-ec2.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  from_port = 0
  to_port = 0
}

resource "aws_instance" "ec2-instance" {
  for_each               = toset(local.instances_names)
  ami                    = "ami-039675294319aca86"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg-ec2.id]
  associate_public_ip_address = true

  # user_data = templatefile("${path.module}/userdata.sh", {})

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = {
    Name = each.value
  }
}