resource "konnect_gateway_consumer_group" "kassongo_group" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  name             = "kassongo_group"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_consumer_group" "paiya_group" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  name             = "paiya_group"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_consumer_group_member" "kassongo_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.kassongo_group.id
  consumer_id       = konnect_gateway_consumer.kassongo_user.id
  control_plane_id  = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
}

resource "konnect_gateway_consumer_group_member" "demo_user_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.kassongo_group.id
  consumer_id       = konnect_gateway_consumer.demouser.id
  control_plane_id  = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
}

resource "konnect_gateway_consumer_group_member" "katika_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.paiya_group.id
  consumer_id       = konnect_gateway_consumer.katika.id
  control_plane_id  = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
}

resource "konnect_gateway_consumer_group_member" "atalaku_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.paiya_group.id
  consumer_id       = konnect_gateway_consumer.atalaku.id
  control_plane_id  = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
}