resource "aws_cloudfront_distribution" "cf" {
  comment          = "${var.name}-cf"
  price_class      = "PriceClass_200"
  retain_on_delete = true
  enabled          = true

  #web_acl_id       = "${aws_waf_web_acl.ip_match_rule.id}"

  origin {
    domain_name = "${aws_elb.elb.dns_name}"
    origin_id   = "ELB-${aws_elb.elb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
    }
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "ELB-${aws_elb.elb.name}"

    forwarded_values {
      query_string = true
      headers      = ["*"]

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
