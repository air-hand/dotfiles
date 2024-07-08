locals {
  labels = {
    dependencies = {
      color       = "0366D6"
      description = "Pull requests that update a dependency file"
    },
    major = {
      color = "FF0000"
    },
    minor = {
      color = "00FF00"
    },
    patch = {
      color = "0000FF"
    },
    terraform-deps = {
      color = "CCCCFF"
    },
  }
}

resource "github_issue_label" "dependencies" {
  for_each = local.labels

  repository  = data.github_repository.current.name
  name        = each.key
  color       = each.value.color
  description = lookup(each.value, "description", null)
}
