# SNS Topic for CloudTrail Notifications
resource "aws_sns_topic" "cloudtrail_alerts" {
  name = "cloudtrail-alerts-topic"
}

# Allow CloudTrail to publish to the SNS topic
resource "aws_sns_topic_policy" "cloudtrail_topic_policy" {
  arn = aws_sns_topic.cloudtrail_alerts.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudTrailPublish",
        Effect    = "Allow",
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        },
        Action    = "sns:Publish",
        Resource  = aws_sns_topic.cloudtrail_alerts.arn
      }
    ]
  })
}

# CloudTrail resource with SNS integration
resource "aws_cloudtrail" "this" {
  name                          = var.name
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = var.cloudwatch_log_group_arn
  cloud_watch_logs_role_arn     = var.cloudwatch_role_arn
  kms_key_id                    = var.kms_key_id

  sns_topic_name = aws_sns_topic.cloudtrail_alerts.name

  tags = var.tags
}

# Subscribe Email to SNS Topic
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.cloudtrail_alerts.arn
  protocol  = "email"
  endpoint  = "soundaryacshcl@gmail.com" # You will receive a confirmation email
}
