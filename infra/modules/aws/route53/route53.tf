resource "aws_route53_zone" "fomiller_subdomain_public" {
  name = "${var.environment}.aws.fomiller.com"
}

resource "aws_route53_zone" "fomillercloud_subdomain_public" {
  name = "${var.environment}.aws.fomillercloud.com"
}

resource "aws_route53_zone" "fomillercloud_cluster_subdomain_public" {
  name = "${var.namespace}-cluster.${var.environment}.aws.fomillercloud.com"
}

resource "aws_route53_record" "fomiller_subdomain_public_ns" {
  provider        = aws.org
  allow_overwrite = true
  name            = "${var.environment}.aws"
  ttl             = 172800
  type            = "NS"
  zone_id         = data.aws_route53_zone.fomiller.zone_id

  records = aws_route53_zone.fomiller_subdomain_public.name_servers
}

resource "aws_route53_record" "fomillercloud_subdomain_public_ns" {
  provider        = aws.org
  allow_overwrite = true
  name            = "${var.environment}.aws"
  ttl             = 172800
  type            = "NS"
  zone_id         = data.aws_route53_zone.fomillercloud.zone_id

  records = aws_route53_zone.fomillercloud_subdomain_public.name_servers
}

resource "aws_route53_record" "fomillercloud_cluster_subdomain_public_ns" {
  provider        = aws.org
  allow_overwrite = true
  name            = "${var.namespace}-cluster.${var.environment}.aws"
  ttl             = 172800
  type            = "NS"
  zone_id         = data.aws_route53_zone.fomillercloud.zone_id

  records = aws_route53_zone.fomillercloud_cluster_subdomain_public.name_servers
}
