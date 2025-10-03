resource "konnect_gateway_consumer_group" "kassongo_group" {
  control_plane_id = var.control_plane_id
  name             = "kassongo_group"
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_consumer_group" "paiya_group" {
  control_plane_id = var.control_plane_id
  name             = "paiya_group"
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_consumer_group_member" "kassongo_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.kassongo_group.id
  consumer_id       = var.consumer_kassongo_id
  control_plane_id  = var.control_plane_id
}

resource "konnect_gateway_consumer_group_member" "demo_user_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.kassongo_group.id
  consumer_id       = var.consumer_demouser_id
  control_plane_id  = var.control_plane_id
}

resource "konnect_gateway_consumer_group_member" "katika_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.paiya_group.id
  consumer_id       = var.consumer_katika_id
  control_plane_id  = var.control_plane_id
}

resource "konnect_gateway_consumer_group_member" "atalaku_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.paiya_group.id
  consumer_id       = var.consumer_atalaku_id
  control_plane_id  = var.control_plane_id
}
