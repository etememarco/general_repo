resource "konnect_gateway_consumer" "kassongo_user" {
  control_plane_id = var.control_plane_id
  tags = [
    "env: uat"
  ]
  username = "Kassongo"
}

resource "konnect_gateway_consumer" "demouser" {
  control_plane_id = var.control_plane_id
  username         = "demo-user"
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_consumer" "katika" {
  control_plane_id = var.control_plane_id
  username         = "katika"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_consumer" "atalaku" {
  control_plane_id = var.control_plane_id
  username         = "atalaku"
  tags = [
    "env: uat"
  ]
}


