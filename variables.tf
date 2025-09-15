variable "konnect_pat" {
  description = "Personal Access Token pour Kong Konnect"
  type        = string
  default     = "kpat_Y6JWSi0RuOu6R0YWZZvQ7s6rhrFSyp5Pdn11NdnmeDegKjN3v"
}

variable "consumer_username" {
  description = "Nom du consumer pour Basic Auth"
  type        = string
  default     = "demo-user"
}

variable "control_plane_id" {
  description = "Nom du consumer pour Basic Auth"
  type        = string
  default     = "demo-user"
}