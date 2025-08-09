# Get all public subnets fronm the defaukt VPC
data "aws_subnets" "public-default-subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default-vpc.id]
  }
}

resource "aws_security_group" "alb-sg" {
  name        = "ALB SG"
  description = "Security grouup that will accept all the traffic"
  vpc_id      = data.aws_vpc.default-vpc.id

  tags = {
    Name = "ALB Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-HTTP-traffic" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "outbound-egress-alb" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  from_port = 0
  to_port = 0
}

resource "aws_lb" "alb-for-ec2-instances" {
  name               = "my-alb-for-ec2-instances"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = data.aws_subnets.public-default-subnets.ids

  enable_deletion_protection = false

  tags = {
    Name = "My ALB Created through Terraform"
  }
}

resource "aws_lb_target_group" "target-group-for-alb" {
  name     = "my-target-group-for-my-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb-for-ec2-instances.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-for-alb.arn
  }
}

resource "aws_lb_target_group_attachment" "alb-targetgroup-attachment" {
  for_each         = aws_instance.ec2-instance
  target_group_arn = aws_lb_target_group.target-group-for-alb.arn
  target_id        = each.value.id
  port             = 80
}

output "alb-dns-name" {
  value = aws_lb.alb-for-ec2-instances.dns_name
}