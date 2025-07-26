variable "name" {
  description = "CloudTrail name"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket for CloudTrail logs"
  type        = string
}

variable "cloudwatch_log_group_arn" {
  description = "CloudWatch Logs group ARN"
  type        = string
}

variable "cloudwatch_role_arn" {
  description = "IAM role ARN that allows CloudTrail to publish to CloudWatch"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ID for encrypting CloudTrail logs"
  type        = string
}

variable "tags" {
  description = "Tags to apply to CloudTrail"
  type        = map(string)
  default     = {}
}
