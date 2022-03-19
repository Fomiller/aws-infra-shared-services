generate provider {
  path = "provider"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::123456789:role/terragrunt"
    }
  }
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "fomiller-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "my-lock-table"
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

