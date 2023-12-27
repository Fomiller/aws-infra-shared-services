include "root" {
	path = find_in_parent_folders()
}

dependency "elasticache" {
    config_path = "../elasticache/"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        elasticache_configuration_endpoint_redis = "MOCK.mock.000.use1.cache.amazonaws.com:0000"
    }
}


inputs = {
    elasticache_configuration_endpoint_redis = dependency.elasticache.outputs.elasticache_configuration_endpoint_redis
}
