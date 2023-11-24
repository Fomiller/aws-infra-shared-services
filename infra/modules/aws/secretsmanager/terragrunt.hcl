include "root" {
  path = find_in_parent_folders()
}

dependency "kms" {
    config_path = "../kms"
    mock_outputs = {
        kms_key_arn_master = "arn:aws:kms:us-east-1:${get_env("TF_VAR_account_id")}:key/506a4c8b-bebb-4dce-9d17-55e49ce9d33c"
    }
}

inputs = {
   kms_key_arn_master = dependency.kms.outputs.kms_key_arn_master 
}

