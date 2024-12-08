include "root" {
	path = find_in_parent_folders()
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        vpc_id = "MOCK-${uuid()}"
    }
}

inputs = {
    vpc_id = dependency.vpc.outputs.vpc_id
}
