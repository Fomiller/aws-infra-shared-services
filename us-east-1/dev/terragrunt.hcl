locals {
  region_vars       = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  aws_region  = local.region_vars.locals.aws_region
}

generate provider {
  path      = "provider"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::123456789:role/terragrunt"
  }
  region = "${local.aws_region}"
  default_tags {
    tags = {
      email = "forrestmillerj@gmail.com"
    }
  }
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "fomiller-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "my-lock-table"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    /* arguments = [ */
    /*   "-var-file=../common.tfvars", */
    /*   "-var-file=../region.tfvars" */
    /* ] */
  }
}

inputs = merge(
  local.region_vars.locals,
  {
    app_prefix = "fomiller"
    extra_tags = {
    }
  }
)

