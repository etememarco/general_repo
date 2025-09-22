resource "konnect_gateway_plugin_key_auth" "gateway_plugin_keyauth" {
  config = {
    hide_credentials = false
    key_in_body      = false
    key_in_header    = true
    key_in_query     = false
    key_names = [
      "apikey"
    ]
    run_on_preflight = false
  }
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  enabled          = false
  instance_name    = "key-auth"
  protocols = [
    "https"
  ]
  service = {
    id = konnect_gateway_service.Kassongo_service.id
  }
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_plugin_rate_limiting_advanced" "gateway_plugin_rate_limiting_advanced" {
  config = {
    identifier          = "ip"
    limit               = [100]
    window_size         = [3600]
    window_type         = "sliding"
    error_code          = 429
    error_message       = "you reached your requests limit"
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


resource "konnect_gateway_plugin_rate_limiting_advanced" "gateway_plugin_rate_limiting_advanced_httpbun" {
  config = {
    identifier          = "ip"
    limit               = [100]
    window_size         = [3600]
    window_type         = "sliding"
    error_code          = 429
    error_message       = "you reached your requests limit"
    hide_client_headers = false
  }

  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  enabled          = true
  instance_name    = "rate_limiting_advanced_httpbun"

  protocols = ["http", "https"]
  service = {
    id = konnect_gateway_service.httpbun.id
  }
  tags = ["env: uat"]
}


resource "konnect_gateway_plugin_basic_auth" "basicauth" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  created_at       = 6
  enabled          = true
  instance_name    = "httpbun_basic_auth"
  protocols        = ["http", "https"]
  service          = { id = konnect_gateway_service.httpbun.id }
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_plugin_basic_auth" "kassongo_basic_auth" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  created_at       = 6
  enabled          = true
  instance_name    = "kassongo_basic_auth"
  protocols        = ["http", "https"]
  service          = { id = konnect_gateway_service.Kassongo_service.id }
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_plugin_acl" "kassongo_acl" {
  config = {
    allow                           = []
    always_use_authenticated_groups = false
    deny = [
      "paiya_group"
    ]
    hide_groups_header      = false
    include_consumer_groups = false
  }
  enabled = true
  protocols = [
    "grpc",
    "grpcs",
    "http",
    "https"
  ]
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  service          = { id = konnect_gateway_service.Kassongo_service.id }
}


resource "konnect_gateway_plugin_acl" "paiya_acl" {
  config = {
    allow                           = []
    always_use_authenticated_groups = false
    deny = [
      "kassongo_group"
    ]
    hide_groups_header      = false
    include_consumer_groups = false
  }
  enabled = true
  protocols = [
    "grpc",
    "grpcs",
    "http",
    "https"
  ]
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  service          = { id = konnect_gateway_service.httpbun.id }
}



resource "konnect_gateway_plugin_proxy_cache_advanced" "proxy_cache_advanced" {
  config = {
    bypass_on_err = false
    cache_control = false
    cache_ttl = 300
    content_type = [
      "text/plain",
      "application/json"
    ]
    ignore_uri_case = false
    memory = {
      dictionary_name = "kong_db_cache"
    }
    redis = {
      cluster_max_redirections = 5
      connect_timeout = 2000
      connection_is_proxied = false
      database = 0
      host = "httpbin.org"
      keepalive_pool_size = 256
      port = 6379
      read_timeout = 2000
      send_timeout = 2000
      ssl = false
      ssl_verify = false
      timeout = 2000
    }
    request_method = [
      "GET",
      "HEAD"
    ]
    response_code = [
      200,
      404
    ]
    response_headers = {
      X-Cache-Key = true
      X-Cache-Status = true
      age = true
    }
    strategy = "memory"
  }
  enabled = true
  protocols = [
    "grpc",
    "grpcs",
    "http",
    "https"
  ]
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  service          = { id = konnect_gateway_service.Kassongo_service.id }
  tags = [
    "env: uat"
  ]
}
