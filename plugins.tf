resource "konnect_gateway_plugin_key_auth" "gateway_plugin_keyauth" {
  config = {
    # anonymous        = "...my_anonymous..."
    hide_credentials = false
    # identity_realms = [
    #   {
    #     id     = "...my_id..."
    #     region = "...my_region..."
    #     scope  = "cp"
    #   }
    # ]
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
  enabled          = true
  instance_name    = "key-auth"
#   ordering = {
#     after = {
#       access = [
#         "..."
#       ]
#     }
#     before = {
#       access = [
#         "..."
#       ]
#     }
#   }
#   partials = [
#     {
#       id   = "...my_id..."
#       name = "...my_name..."
#       path = "...my_path..."
#     }
#   ]
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