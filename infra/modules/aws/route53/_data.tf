data "aws_route53_zone" "fomiller" {
  provider = aws.org
  name     = "fomiller.com"
}

data "aws_route53_zone" "fomillercloud" {
  provider = aws.org
  name     = "fomillercloud.com"
}

