output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}

output "alarm_name" {
  value = aws_cloudwatch_metric_alarm.trail_delete_alarm.alarm_name
}

