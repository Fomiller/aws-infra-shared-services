# skip = true

dependencies {
    paths = ["../route53", "../cloudwatch"]
}

dependency "roles" {
    config_path = "../iam/roles"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        iam_role_arn_eks_cluster = "arn:aws:iam::${get_env("TF_VAR_account_id")}:role/FomillerEksCluster"
        iam_role_arn_eks_fargate_profile = "arn:aws:iam::${get_env("TF_VAR_account_id")}:role/FomillerEksFargateProfile"
    }
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        vpc_id = "MOCK-${uuid()}"
        subnet_ids_private = [
            "MOCK-private-${uuid()}",
            "MOCK-private-${uuid()}",
        ]
        subnet_ids_public = [
            "MOCK-public-${uuid()}",
            "MOCK-public-${uuid()}",
        ]
    }
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
    iam_role_arn_eks_cluster = dependency.roles.outputs.iam_role_arn_eks_cluster
    iam_role_arn_eks_fargate_profile = dependency.roles.outputs.iam_role_arn_eks_fargate_profile
    subnet_ids_private = dependency.vpc.outputs.subnet_ids_private
    subnet_ids_public = dependency.vpc.outputs.subnet_ids_public
    vpc_id = dependency.vpc.outputs.vpc_id
}
