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
  }
}

resource "github_issue_label" "dependencies" {
  for_each = local.labels

  repository  = data.github_repository.current.name
  name        = each.key
  color       = each.value.color
  description = lookup(each.value, "description", null)
}

import {
  for_each = {
    for k, v in local.labels : k => v
    if k != "major"
  }
  to = github_issue_label.dependencies[each.key]
  id = "${data.github_repository.current.name}:${each.key}"
}
