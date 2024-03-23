resource "github_actions_variable" "tf_cloud_workspace" {
  repository    = data.github_repository.current.full_name
  variable_name = "TF_CLOUD_WORKSPACE"
  value         = "dotfiles"
}
