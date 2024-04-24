# check exists for dependabot.
data "github_dependabot_secrets" "current" {
  full_name = data.github_repository.current.full_name

  lifecycle {
    postcondition {
      condition = alltrue([
        for expected in [
          "TF_API_TOKEN",
          "TF_CLOUD_ORGANIZATION",
          "GH_APP_ID",
          "GH_APP_INSTALLATION_ID",
          "GH_APP_PEM_FILE",
        ] : contains([for s in self.secrets : s.name], expected)
      ])
      error_message = "some secrets are missing"
    }
  }
}
