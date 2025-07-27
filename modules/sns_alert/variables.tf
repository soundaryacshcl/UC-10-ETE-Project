variable "project_name" {
  description = "Project name"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group to monitor (e.g., from CloudTrail)"
  type        = string
}

variable "email_endpoint" {
  description = "Email address to subscribe to the SNS topic"
  type        = string
}
