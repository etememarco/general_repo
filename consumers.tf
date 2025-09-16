resource "konnect_gateway_consumer" "kassongo_consumer" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  tags = [
    "env: uat"
  ]
  username = "Kassongo"
}

resource "konnect_gateway_consumer_group" "kassongo_group" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  name             = "kassongo_group"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_consumer" "demo_user" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  username         = "demo-user"
}
