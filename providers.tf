# terraform {
#   required_providers {
#     kong = {
#       source  = "kong/kong"
#       version = "~> 3.0"
#     }
#   }
# }

# provider "kong" {
#   konnect_email    = var.konnect_email
#   konnect_password = var.konnect_password
#   konnect_server   = "https://cloud.konghq.com"
# }

terraform {
  required_providers {
    konnect = {
      source  = "kong/konnect"
    }
  }
}

provider "konnect" {
  personal_access_token = "kpat_Y6JWSi0RuOu6R0YWZZvQ7s6rhrFSyp5Pdn11NdnmeDegKjN3v"
  server_url            = "https://eu.api.konghq.com"
}