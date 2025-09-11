resource "konnect_gateway_basic_auth" "basicauth" {
  consumer_id      = "c06c1f38-cd46-4669-bfa3-75e3417423db"
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  created_at       = 5
  password         = "Kass_10!"
  tags = [
    "..."
  ]
  username = "Kassongo"
}

resource "konnect_gateway_basic_auth" "demo_user_auth" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  consumer_id = konnect_gateway_consumer.demo_user.id
  username    = "demo-user"
  password    = "demo-password"
}

