resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-cloudtrail-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
}

resource "aws_cloudwatch_log_metric_filter" "trail_delete_filter" {
  name           = "DeleteTrailFilter"
  log_group_name = var.log_group_name
  pattern        = "{ $.eventName = \"DeleteTrail\" }"

  metric_transformation {
    name      = "DeleteTrailCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "trail_delete_alarm" {
  alarm_name          = "${var.project_name}-delete-trail-alarm"
  metric_name         = "DeleteTrailCount"
  namespace           = "CloudTrailMetrics"
  statistic           = "Sum"
  period              = 300
  evaluation_periods  = 1
  threshold           = 1
  comparison_operator = "GreaterThanOrEqualToThreshold"
  alarm_description   = "Triggered when DeleteTrail is called"
  alarm_actions       = [aws_sns_topic.alerts.arn]
}
