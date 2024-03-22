data "github_repository" "current" {
  full_name = "${local.github_owner}/${local.github_repository}"
}
