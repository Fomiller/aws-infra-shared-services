include "root" {
  path = find_in_parent_folders()
}

dependency "policies" {
    config_path = "../policies"
    mock_outputs = {
        iam_policy_arn_lambda_hello = "arn:aws:iam::${get_env("TF_VAR_account_id")}:policy/MOCK-policy"
        iam_policy_arn_ecs_events = "arn:aws:iam::${get_env("TF_VAR_account_id")}:policy/MOCK-policy"
        iam_policy_document_json_lambda = {}
        iam_policy_document_json_eventbridge = {}
    }
}

inputs = {
    iam_policy_arn_lambda_hello = dependency.policies.outputs.iam_policy_arn_lambda_hello
    iam_policy_arn_ecs_events = dependency.policies.outputs.iam_policy_arn_ecs_events
    iam_policy_document_json_lambda = dependency.policies.outputs.iam_policy_document_json_lambda
    iam_policy_document_json_eventbridge = dependency.policies.outputs.iam_policy_document_json_eventbridge
}
