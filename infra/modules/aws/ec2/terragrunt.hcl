include "root" {
	path = find_in_parent_folders()
}

dependency "security" {
    config_path = "../security"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "init", "plan", "apply", "destroy"]
    mock_outputs = {
        security_group_id_bastion = "MOCK-${uuid()}"
    }
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "init", "plan", "apply", "destroy"]
    mock_outputs = {
        subnet_ids_public = [
            "MOCK-public-${uuid()}",
            "MOCK-public-${uuid()}",
        ]
    }
}

inputs = {
    security_group_id_bastion = dependency.security.outputs.security_group_id_bastion
    subnet_ids_public = dependency.vpc.outputs.subnet_ids_public
}
