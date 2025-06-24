data "github_app" "actions" {
  slug = "github-actions"
}


resource "github_repository_ruleset" "main" {
  name        = "main"
  repository  = data.github_repository.current.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = [
        "refs/heads/main",
      ]
      exclude = []
    }
  }

  rules {
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true
    required_signatures     = true

    required_status_checks {
      required_check {
        context        = "check-result"
        integration_id = data.github_app.actions.id
      }
      strict_required_status_checks_policy = true
    }
  }
}
