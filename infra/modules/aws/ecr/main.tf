locals {
  resource_name = "${var.app_prefix}-megatainer"
}

resource "aws_ecr_repository" "megatainer" {
  name                 = local.resource_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.extra_tags
}
