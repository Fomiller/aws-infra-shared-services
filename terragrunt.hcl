generate provider {
  path      = "provider"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::123456789:role/terragrunt"
    }  default_tags {
  region = "${local.aws_region}"
  tags = {
      email = "forrestmillerj@gmail.com"
      environment = "${local.environment}"
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
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  {
    app_prefix = "fomiller"
    extra_tags = {
      Environment = local.environment
      AccountId   = local.account_id
      Region      = local.aws_region
    }
  }
)

