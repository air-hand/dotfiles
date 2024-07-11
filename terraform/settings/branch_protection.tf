resource "github_branch_protection" "main" {
  repository_id = data.github_repository.current.node_id
  pattern       = "main"
  required_status_checks {
    contexts = [
      "check-ci-result",
      "check-tf-result",
    ]
    strict = true
  }
}
