include "root" {
  path = find_in_parent_folders()
}

dependency "roles" {
    config_path = "../roles"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        iam_role_name_lambda_hello = "FomillerLambdaHello"
        iam_role_name_eks_cluster = "FomilerEksCluster"
        iam_role_name_eks_node_groups = "FomillerEksNodeGroups"
        iam_role_name_ecs_fargate_profile = "FomillerEksFargateProfile"
    }
}

inputs = {
    iam_role_name_lambda_hello = dependency.roles.outputs.iam_role_name_lambda_hello
    iam_role_name_eks_cluster = dependency.roles.outputs.iam_role_name_eks_cluster
    iam_role_name_eks_node_groups = dependency.roles.outputs.iam_role_name_eks_node_groups
    iam_role_name_eks_fargate_profile = dependency.roles.outputs.iam_role_name_eks_fargate_profile
}
