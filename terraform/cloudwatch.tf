resource "aws_cloudwatch_metric_alarm" "durianpay-cpu-alarm" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 45
  alarm_description   = "Alert when CPU consumption surpasses 45%, signaling potential overload"
  alarm_actions       = [aws_autoscaling_policy.durianpay-autoscaling-policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "durianpay-memory-alarm" {
  alarm_name          = "HighMemoryUsage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 75
  alarm_description   = "Warning when memory usage exceeds 75%, indicating potential resource exhaustion"
  alarm_actions       = [aws_autoscaling_policy.durianpay-autoscaling-policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "durianpay-status-check-alarm" {
  alarm_name          = "InstanceStatusCheckFailed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  alarm_description   = "Triggered when instance fails its status check, requiring immediate attention"
  alarm_actions       = [aws_autoscaling_policy.durianpay-autoscaling-policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "durianpay-network-usage-alarm" {
  alarm_name          = "HighNetworkUsage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 1000000
  alarm_description   = "Fired when inbound network traffic exceeds 1MB, signaling a spike in data flow"
  alarm_actions       = [aws_autoscaling_policy.durianpay-autoscaling-policy.arn]
}
