resource "aws_cloudfront_distribution" "alb_distribution" {
 enabled             = true
 default_root_object = ""
 origin {
   domain_name = var.alb_dns_name
   origin_id   = "alb-origin"
   custom_origin_config {
     http_port              = 80
     https_port             = 443
     origin_protocol_policy = "https-only"
     origin_ssl_protocols   = ["TLSv1.2"]
   }
 }
 default_cache_behavior {
   target_origin_id       = "alb-origin"
   viewer_protocol_policy = "redirect-to-https"
   allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
   cached_methods         = ["GET", "HEAD"]
   forwarded_values {
     query_string = true
     cookies {
       forward = "all"
     }
   }
 }
 viewer_certificate {
   cloudfront_default_certificate = true
 }
 restrictions {
   geo_restriction {
     restriction_type = "none"
   }
 }
 tags = {
   Project     = var.project_name
   Environment = var.environment
 }
}
