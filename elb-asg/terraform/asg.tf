resource "aws_launch_template" "launch-template" {
  name = "MyDemoTemplate"
  description = "template"
  image_id = "ami-08ddf8e6269e0f32c"
  instance_type = "t2.micro"
  

  network_interfaces {
    security_groups = [aws_security_group.sg-ec2.id]
    associate_public_ip_address = true
    delete_on_termination = true
  }
}

resource "aws_autoscaling_group" "web-app-asg" {
  name = "DemoASG"
  launch_template {
    id = aws_launch_template.launch-template.id
    version = "$Latest"
  }
  
  vpc_zone_identifier = data.aws_subnets.public-default-subnets.ids
  target_group_arns = [aws_lb_target_group.target-group-for-alb.arn]
  health_check_type = "ELB"
  health_check_grace_period = 300 #seconds

  desired_capacity = 3
  min_size = 1
  max_size = 5
}

resource "aws_autoscaling_policy" "scale_out" {
  name = "scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.web-app-asg.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 300
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name = "high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web-app-asg.name
  }

  alarm_description = "Scale out when CPU > 50%"
  alarm_actions = [aws_autoscaling_policy.scale_out.arn]
}

resource "aws_autoscaling_policy" "scale_in" {
  name = "scale-in-policy"
  autoscaling_group_name = aws_autoscaling_group.web-app-asg.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown = 300
}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name = "low-cpu-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 120
  statistic = "Average"
  threshold = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web-app-asg.name
  }

  alarm_description = "Scale in when CPU < 30%"
  alarm_actions = [aws_autoscaling_policy.scale_in.arn]
}
