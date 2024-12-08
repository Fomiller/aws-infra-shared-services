include "root" {
	path = find_in_parent_folders()
}

dependency "security" {
    config_path = "../security"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "init", "plan", "apply", "destroy"]
    mock_outputs = {
        security_group_id_rds = "MOCK-${uuid()}"
    }
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "init", "plan", "apply", "destroy"]
    mock_outputs = {
        db_subnet_group_name_private = "MOCK-subnet-group-name"
    }
}

inputs = {
    security_group_id_rds = dependency.security.outputs.security_group_id_rds
    db_subnet_group_name_private = dependency.vpc.outputs.db_subnet_group_name_private
}
