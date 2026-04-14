resource "github_actions_variable" "tf_cloud_workspace" {
  repository    = data.github_repository.current.name
  variable_name = "TF_CLOUD_WORKSPACE"
  value         = "dotfiles"
}

resource "github_actions_variable" "gh_app_client_id" {
  repository    = data.github_repository.current.name
  variable_name = "GH_APP_CLIENT_ID"
  value         = "Iv1.2fe071558871cd68"
}
