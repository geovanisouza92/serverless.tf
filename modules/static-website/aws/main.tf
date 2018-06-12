resource "aws_s3_bucket" "root_domain_bucket" {
  bucket = "${var.hosting_domain}"
  acl    = "public-read"

  website = {
    index_document = "${var.content_index}"
    error_document = "${var.content_error}"
  }
}

resource "aws_s3_bucket" "www_domain_bucket" {
  bucket = "${var.alias_domain}"
  acl    = "public-read"

  website = {
    redirect_all_requests_to = "${aws_s3_bucket.root_domain_bucket.website_endpoint}"
  }
}

resource "aws_s3_bucket_policy" "root_domain_policy" {
  bucket = "${aws_s3_bucket.root_domain_bucket.arn}"

  # TODO
  policy = <<POLICY
  {}
POLICY
}

resource "aws_cloudfront_distribution" "site_cdn_config" {
  default_root_object = "${var.content_index}"
  aliases             = ["${var.alias_domain}"]
  enabled             = true

  origin {
    domain_name = "${var.hosting_domain}.s3.amazonaws.com"
    origin_id   = "${var.hosting_domain}"
  }

  # TODO: Review this
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["*"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_route53_zone" "site_zone_config" {
  name = "${var.name}-site-${var.alias_domain}"
}

resource "aws_route53_record" "site_domain_config" {
  zone_id = "${aws_route53_zone.site_zone_config.zone_id}"
  name    = "${var.name}-site-${var.alias_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_cloudfront_distribution.site_cdn_config.domain_name}"]
}
