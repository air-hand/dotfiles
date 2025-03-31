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
        context = "check-ci-result"
      }
      required_check {
        context = "check-tf-result"
      }
      strict_required_status_checks_policy = true
    }
  }
}
