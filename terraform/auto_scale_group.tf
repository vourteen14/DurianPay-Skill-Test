resource "aws_security_group" "durianpay-security-group" {
  name                        = "app-security-group"
  vpc_id                      = aws_vpc.durianpay-vpc.id
}

resource "aws_launch_template" "durianpay-launch-template" {
  name                          = "durianpay-launch-template"
  image_id                      = "ami-005fc0f236362e99f"
  instance_type                 = "t2.medium"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.durianpay-security-group.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "durianpay-autoscaling-group" {
  vpc_zone_identifier       = [aws_subnet.durianpay-subnet-private.id]
  desired_capacity          = 2
  max_size                  = 5
  min_size                  = 2
  health_check_type         = "EC2"
  wait_for_capacity_timeout = "0"

  launch_template {
    id      = aws_launch_template.durianpay-launch-template.id
    version = "$Latest"
  }

  tag {
    key                       = "Name"
    value                     = "durianpay-ec2-instance"
    propagate_at_launch       = true
  }
}

resource "aws_autoscaling_policy" "durianpay-autoscaling-policy" {
  name                        = "durianpay-autoscaling-policy"
  autoscaling_group_name      = aws_autoscaling_group.durianpay-autoscaling-group.id
  policy_type                 = "TargetTrackingScaling"
  estimated_instance_warmup   = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type  = "ASGAverageCPUUtilization"
    }
    target_value              = 45.0
  }
}