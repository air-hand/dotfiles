terraform {
  required_version = "1.10.3"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }
  }
}
