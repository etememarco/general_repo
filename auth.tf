resource "konnect_gateway_basic_auth" "basicauth" {
  consumer_id      = konnect_gateway_consumer.kassongo_user.id
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  tags = [
    "env: uat"
  ]
  username = "Kassongo"
  password = "Kass_10!"
}

resource "konnect_gateway_basic_auth" "demo_user_auth" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  consumer_id      = konnect_gateway_consumer.demouser.id
  username         = "demo-user"
  password         = "demo-password"
}

resource "konnect_gateway_basic_auth" "katika_auth" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  consumer_id      = konnect_gateway_consumer.katika.id
  username         = "katika"
  password         = "oklmradio"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_basic_auth" "atalaku_auth" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  consumer_id      = konnect_gateway_consumer.atalaku.id
  username         = "atalaku"
  password         = "oklmradio10!"
  tags = [
    "env: uat"
  ]
}




# resource "konnect_gateway_key_auth" "keyauth_kassongo" {
#   consumer_id      = konnect_gateway_consumer.kassongo_user.id
#   control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
#   key              = "kassongo"
#   tags = [
#     "env: uat"
#   ]
#   ttl = 5
# }

# resource "konnect_gateway_key_auth" "keyauth_demouser" {
#   consumer_id       = konnect_gateway_consumer.demouser.id
#   control_plane_id  = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
#   key              = "demouser"
#   tags = [
#     "env: uat"
#   ]
#   ttl = 5
# }

# resource "konnect_gateway_key_auth" "keyauth_katika" {
#   consumer_id      = konnect_gateway_consumer.katika.id
#   control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
#   key              = "katika"
#   tags = [
#     "env: uat"
#   ]
#   ttl = 5
# }