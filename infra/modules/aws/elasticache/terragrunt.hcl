include "root" {
	path = find_in_parent_folders()
}

dependency "cloudwatch" {
    config_path = "../cloudwatch/"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        cloudwatch_log_group_name_redis = "/aws/MOCK/redis"
    }
}

inputs = {
    cloudwatch_log_group_name_redis = dependency.cloudwatch.outputs.cloudwatch_log_group_name_redis
}
