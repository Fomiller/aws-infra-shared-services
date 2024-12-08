skip = true
include "root" {
	path = find_in_parent_folders()
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

# dependency "eks" {
#     config_path = "../eks"
#     mock_outputs_merge_strategy_with_state = "shallow"
#     mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
#     mock_outputs = {
#         eks_cluster_default_security_group_id = "sg-mock-${uuid()}"
#     }
# }

inputs = {
    subnet_ids_private = dependency.vpc.outputs.subnet_ids_private
    subnet_ids_public = dependency.vpc.outputs.subnet_ids_public
    vpc_id = dependency.vpc.outputs.vpc_id
    # eks_cluster_default_security_group_id = dependency.eks.outputs.eks_cluster_default_security_group_id
}
