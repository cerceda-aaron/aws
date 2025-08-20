data "aws_vpc" "default-vpc" {
  default = true
}

data "aws_ami" "custom-ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "name"
    values = ["node-server-ami"]
  }
}


resource "aws_security_group" "ec2-sg" {
  name = "ec2-instances-sg-group"
  description = "Security GRoup for the EC2 instance"
  vpc_id = data.aws_vpc.default-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.ec2-sg.id
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
}

resource "aws_instance" "instance_ec2" {
    ami = data.aws_ami.custom-ami.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ec2-sg.id]
    associate_public_ip_address = true

    root_block_device {
      delete_on_termination = true
      volume_size = 10
      volume_type = "gp3"
    }

    tags = {
      Name = "testing-service"
    }
}