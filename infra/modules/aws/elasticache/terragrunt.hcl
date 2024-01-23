include "root" {
	path = find_in_parent_folders()
}

dependency "vpc" {
    config_path = "../vpc/"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
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
