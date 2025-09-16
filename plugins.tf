resource "konnect_gateway_plugin_key_auth" "gateway_plugin_keyauth" {
  config = {
    hide_credentials = false
    key_in_body      = false
    key_in_header    = true
    key_in_query     = false
    key_names = [
      "key-auth"
    ]
    realm            = "my_realm"
    run_on_preflight = false
  }
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  enabled          = false
  instance_name    = "key-auth"
  protocols = [
    "https"
  ]
  route = {
    id = konnect_gateway_route.Kassongo_route.id
  }
  service = {
    id = konnect_gateway_service.Kassongo_service.id
  }
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_plugin_rate_limiting_advanced" "gateway_plugin_rate_limiting_advanced" {
  config = {
    identifier         = "ip"
    limit              = [10]
    window_size        = [60]
    window_type        = "sliding"
    error_code         = 429
    error_message      = "you reached your requests limit"
    hide_client_headers = false
  }

  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  enabled          = true
  instance_name    = "rate_limiting_advanced"

  protocols = ["http", "https"]
  service = {
    id = konnect_gateway_service.Kassongo_service.id
  }
  tags = ["env: uat"]
}
