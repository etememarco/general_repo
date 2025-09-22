resource "konnect_gateway_consumer" "kassongo_user" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  tags = [
    "env: uat"
  ]
  username = "Kassongo"
}

resource "konnect_gateway_consumer" "demouser" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  username         = "demo-user"
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_consumer" "katika" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  username         = "katika"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_consumer" "atalaku" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  username         = "atalaku"
  tags = [
    "env: uat"
  ]
}