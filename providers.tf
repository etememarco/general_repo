
terraform {
  required_providers {
    konnect = {
      source = "kong/konnect"
    }
  }
}

provider "konnect" {
  personal_access_token = "kpat_Y6JWSi0RuOu6R0YWZZvQ7s6rhrFSyp5Pdn11NdnmeDegKjN3v"
  server_url            = "https://eu.api.konghq.com"
}