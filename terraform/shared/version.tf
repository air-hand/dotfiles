terraform {
  required_version = "1.8.2"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }
  }
}
