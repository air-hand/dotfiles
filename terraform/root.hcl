generate "remote_state" {
  path      = "_backend.tf"
  if_exists = "overwrite"
  contents = templatefile("shared/backend.tftpl", {
    TF_CLOUD_ORGANIZATION = get_env("TF_CLOUD_ORGANIZATION")
    TF_CLOUD_WORKSPACE = get_env("TF_CLOUD_WORKSPACE")
  })
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("shared/provider.tf")
}

generate "version" {
  path      = "_version.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("shared/version.tf")
}

generate "locals" {
  path      = "_locals.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("shared/locals.tf")
}

generate "data" {
  path      = "_data.tf"
  if_exists = "overwrite_terragrunt"
  contents  = file("shared/data.tf")
}

terraform {
  after_hook "validate_tflint" {
    commands = ["validate"]
    execute = [
      "tflint",
      "--terragrunt-external-tflint",
      "--config",
      "${get_repo_root()}/terraform/.tflint.hcl"
    ]
  }
}
