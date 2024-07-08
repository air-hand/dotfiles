locals {
  labels = [
    {
      name  = "dependencies"
      color = "CCCCCC"
    },
    {
      name  = "major"
      color = "FF0000"
    },
    {
      name  = "minor"
      color = "00FF00"
    },
    {
      name  = "patch"
      color = "0000FF"
    },
  ]
}

resource "github_issue_labels" "dependencies" {
  repository = data.github_repository.current.name

  dynamic "label" {
    for_each = local.labels
    content {
      name  = label.value.name
      color = label.value.color
    }
  }
}
