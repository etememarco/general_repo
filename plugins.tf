resource "konnect_gateway_plugin_key_auth" "gateway_plugin_keyauth" {
  config = {
    hide_credentials = false
    key_in_body   = false
    key_in_header = false
    key_in_query  = true
    key_names = [
      "key-auth"
    ]
    realm            = "...my_realm..."
    run_on_preflight = false
  }
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  created_at       = 5
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


resource "konnect_gateway_plugin_rate_limiting" "gateway_plugin_rate_limiting" {
  config = {
    day                 = 1
    error_code          = 7.45
    error_message       = "you have reached your requests limit"
    fault_tolerant      = true
    hide_client_headers = false
    hour                = 1
    limit_by            = "ip"
    minute              = 1
    month               = 1
    # path                = "...my_path..."
    policy              = "local"
    second    = 1
    year      = 1
  }

  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  enabled          = true
  instance_name    = "rate_limiting"
  protocols = [
    "grpc"
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