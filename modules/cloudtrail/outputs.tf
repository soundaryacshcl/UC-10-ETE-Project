output "cloudtrail_name" {
  value = aws_cloudtrail.trail.name
}

output "cloudtrail_s3_bucket" {
  value = aws_s3_bucket.cloudtrail_logs.id
}

output "cloudtrail_log_group" {
  value = var.enable_cloudwatch_logs ? aws_cloudwatch_log_group.trail_log_group[0].name : ""
}
