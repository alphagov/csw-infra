resource "aws_cloudfront_distribution" "cf_distribution" {
  origin {
    domain_name = "${var.api_gateway_url}"
    origin_id   = "${local.cf_origin_id}"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = "TLSv1.2"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Managed by Terraform"

  aliases = ["${local.target_url}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "POST"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.cf_origin_id}"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Only US and Europe - there's no smaller option
  # https://aws.amazon.com/cloudfront/pricing/
  price_class = "PriceClass_100"

  # Restrict traffic to IPS identified as UK
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["GB"]
    }
  }

  # Further restrict with WAF ACL to GDS IPs
  web_acl_id = "${aws_waf_web_acl.waf_acl.id}"

  tags = {
    Environment = "${var.env}"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }


}