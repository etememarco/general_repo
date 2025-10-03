resource "konnect_gateway_basic_auth" "basicauth" {
  consumer_id      = konnect_gateway_consumer.kassongo_user.id
  control_plane_id = var.control_plane_id
  tags             = ["env: uat"]
  username         = "Kassongo"
  password         = var.kassongo_password
}

resource "konnect_gateway_basic_auth" "demo_user_auth" {
  consumer_id      = konnect_gateway_consumer.demouser.id
  control_plane_id = var.control_plane_id
  username         = "demo-user"
  password         = var.demouser_password
}

resource "konnect_gateway_basic_auth" "katika_auth" {
  consumer_id      = konnect_gateway_consumer.katika.id
  control_plane_id = var.control_plane_id
  username         = "katika"
  password         = var.katika_password
  tags             = ["env: uat"]
}

resource "konnect_gateway_basic_auth" "atalaku_auth" {
  consumer_id      = konnect_gateway_consumer.atalaku.id
  control_plane_id = var.control_plane_id
  username         = "atalaku"
  password         = var.atalaku_password
  tags             = ["env: uat"]
}



