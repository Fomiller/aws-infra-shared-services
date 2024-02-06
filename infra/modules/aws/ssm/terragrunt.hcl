include "root" {
	path = find_in_parent_folders()
}

dependency "efs" {
    config_path = "../efs/"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        efs_id = "fs-mock${uuid()}"
    }
}


inputs = {
    efs_id = dependency.efs.outputs.efs_id
}
