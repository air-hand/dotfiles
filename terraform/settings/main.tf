resource "github_branch_protection" "main" {
  repository_id = data.github_repository.current.node_id
  pattern       = "main"
  required_status_checks {
    contexts = [
      "run-install-test (debian)",
      "run-install-test (ubuntu)",
    ]
    strict = true
  }
}
