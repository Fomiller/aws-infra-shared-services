resource "aws_acm_certificate" "fomillercloud_subdomain_public_cert" {
  domain_name       = var.route53_zone_name_fomillercloud_subdomain_public
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.route53_zone_name_fomillercloud_subdomain_public}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "fomillercloud_cluster_subdomain_public_cert" {
  domain_name       = var.route53_zone_name_fomillercloud_cluster_subdomain_public
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.route53_zone_name_fomillercloud_cluster_subdomain_public}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "fomillercloud_subdomain_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.fomillercloud_subdomain_public_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_zone_id_fomillercloud_subdomain_public
}

resource "aws_route53_record" "fomillercloud_cluster_subdomain_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.fomillercloud_cluster_subdomain_public_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_zone_id_fomillercloud_cluster_subdomain_public
}

resource "aws_acm_certificate_validation" "fomillercloud_subdomain_cert_validation" {
  certificate_arn         = aws_acm_certificate.fomillercloud_subdomain_public_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.fomillercloud_subdomain_cert_validation : record.fqdn]
}

resource "aws_acm_certificate_validation" "fomillercloud_cluster_subdomain_cert_validation" {
  certificate_arn         = aws_acm_certificate.fomillercloud_cluster_subdomain_public_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.fomillercloud_cluster_subdomain_cert_validation : record.fqdn]
}
