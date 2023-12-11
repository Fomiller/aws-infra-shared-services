include "root" {
	path = find_in_parent_folders()
}

dependency "route53" {
    config_path = "../route53/"
    mock_outputs_merge_strategy_with_state = "shallow"
    mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
    mock_outputs = {
        route53_zone_name_fomillercloud_subdomain_public = "MOCK.aws.fomillercloud.com"
        route53_zone_id_fomillercloud_subdomain_public = "1234567689012"
    }
}

inputs = {
    route53_zone_name_fomillercloud_subdomain_public = dependency.route53.outputs.route53_zone_name_fomillercloud_subdomain_public
    route53_zone_id_fomillercloud_subdomain_public = dependency.route53.outputs.route53_zone_id_fomillercloud_subdomain_public
}
