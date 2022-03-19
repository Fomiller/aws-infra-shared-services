resource "aws_s3_bucket" "bucket" {
  bucket = "fomiller-dev"

  tags = {
    Owner       = "Forrest Miller"
    Email       = "forrestmillerj@gmail.com"
    Environment = "Dev"
  }
}
