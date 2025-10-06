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
  control_plane_id = var.control_plane_id
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

  control_plane_id = var.control_plane_id
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

  control_plane_id = var.control_plane_id
  enabled          = true
  instance_name    = "rate_limiting_advanced_httpbun"

  protocols = ["http", "https"]
  service = {
    id = konnect_gateway_service.httpbun.id
  }
  tags = ["env: uat"]
}


resource "konnect_gateway_plugin_basic_auth" "basicauth" {
  control_plane_id = var.control_plane_id
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
  control_plane_id = var.control_plane_id
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
  control_plane_id = var.control_plane_id
  service          = { id = konnect_gateway_service.Kassongo_service.id }
  tags = [
    "env: uat"
  ]
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
  control_plane_id = var.control_plane_id
  service          = { id = konnect_gateway_service.httpbun.id }
  tags = [
    "env: uat"
  ]
}



resource "konnect_gateway_plugin_proxy_cache_advanced" "proxy_cache_advanced" {
  config = {
    bypass_on_err = false
    cache_control = false
    cache_ttl     = 300
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
      connect_timeout          = 2000
      connection_is_proxied    = false
      database                 = 0
      host                     = "httpbin.org"
      keepalive_pool_size      = 256
      port                     = 6379
      read_timeout             = 2000
      send_timeout             = 2000
      ssl                      = false
      ssl_verify               = false
      timeout                  = 2000
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
      X-Cache-Key    = true
      X-Cache-Status = true
      age            = true
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
  control_plane_id = var.control_plane_id
  service          = { id = konnect_gateway_service.Kassongo_service.id }
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_plugin_openid_connect" "openid_connect" {
  config = {
    audience_claim = [
      "aud"
    ]
    auth_methods = [
      "password",
      "client_credentials",
      "authorization_code",
      "bearer",
      "introspection",
      "userinfo",
      "kong_oauth2",
      "refresh_token",
      "session"
    ]
    authorization_cookie_http_only = true
    authorization_cookie_name      = "authorization"
    authorization_cookie_path      = "/"
    authorization_cookie_same_site = "Default"
    authorization_rolling_timeout  = 600
    bearer_token_param_type = [
      "header",
      "query",
      "body"
    ]
    by_username_ignore_case = false
    cache_introspection     = true
    cache_token_exchange    = true
    cache_tokens            = true
    cache_tokens_salt       = var.cache_tokens_salt
    cache_ttl               = 3600
    cache_user_info         = true
    client_arg              = "client_id"
    client_credentials_param_type = [
      "header",
      "query",
      "body"
    ]
    client_id     = [var.client_id]
    client_secret = [var.client_secret]
    cluster_cache_redis = {
      cluster_max_redirections = 5
      connect_timeout          = 2000
      connection_is_proxied    = false
      database                 = 0
      host                     = "127.0.0.1"
      keepalive_pool_size      = 256
      port                     = 6379
      read_timeout             = 2000
      send_timeout             = 2000
      ssl                      = false
      ssl_verify               = false
      timeout                  = 2000
    }
    cluster_cache_strategy = "off"
    consumer_by = [
      "username",
      "custom_id"
    ]
    consumer_groups_optional = false
    consumer_optional        = false
    credential_claim = [
      "sub"
    ]
    display_errors            = false
    dpop_proof_lifetime       = 300
    dpop_use_nonce            = false
    enable_hs_signatures      = false
    expose_error_code         = true
    forbidden_destroy_session = true
    forbidden_error_message   = "Forbidden"
    groups_claim = [
      "groups"
    ]
    hide_credentials = false
    http_version     = 1.1
    id_token_param_type = [
      "header",
      "query",
      "body"
    ]
    ignore_signature               = []
    introspect_jwt_tokens          = false
    introspection_accept           = "application/json"
    introspection_check_active     = true
    introspection_hint             = "access_token"
    introspection_token_param_name = "token"
    issuer                         = var.issuer
    jwt_session_claim              = "sid"
    keepalive                      = true
    leeway                         = 0
    login_action                   = "upstream"
    login_methods = [
      "authorization_code"
    ]
    login_redirect_mode = "fragment"
    login_tokens = [
      "id_token"
    ]
    logout_methods = [
      "POST",
      "DELETE"
    ]
    logout_revoke               = false
    logout_revoke_access_token  = true
    logout_revoke_refresh_token = true
    password_param_type = [
      "header",
      "query",
      "body"
    ]
    preserve_query_args                         = false
    proof_of_possession_auth_methods_validation = true
    proof_of_possession_dpop                    = "off"
    proof_of_possession_mtls                    = "off"
    redirect_uri = [
      "https://kong-4959cb460beu2yuvj.kongcloud.dev/oidc/callback"
    ]
    redis = {
      cluster_max_redirections = 5
      connect_timeout          = 2000
      connection_is_proxied    = false
      database                 = 0
      host                     = "127.0.0.1"
      keepalive_pool_size      = 256
      port                     = 6379
      read_timeout             = 2000
      send_timeout             = 2000
      ssl                      = false
      ssl_verify               = false
      timeout                  = 2000
    }
    rediscovery_lifetime = 30
    refresh_token_param_type = [
      "header",
      "query",
      "body"
    ]
    refresh_tokens             = true
    resolve_distributed_claims = false
    response_mode              = "query"
    response_type = [
      "code"
    ]
    reverify                    = false
    revocation_token_param_name = "token"
    roles_claim = [
      "roles"
    ]
    run_on_preflight = true
    scopes = [
      "openid"
    ]
    scopes_claim = [
      "scope"
    ]
    scopes_required = [
      "kassongo:read",
      "kassongo:write"
    ]
    search_user_info                       = false
    session_absolute_timeout               = 86400
    session_audience                       = "default"
    session_compressor                     = "none"
    session_cookie_http_only               = true
    session_cookie_maxsize                 = 4000
    session_cookie_name                    = "session"
    session_cookie_path                    = "/"
    session_cookie_renew                   = 600
    session_cookie_same_site               = "Lax"
    session_enforce_same_subject           = false
    session_hash_storage_key               = false
    session_hash_subject                   = false
    session_idling_timeout                 = 900
    session_memcached_host                 = "127.0.0.1"
    session_memcached_port                 = 11211
    session_redis_cluster_max_redirections = 5
    session_redis_connect_timeout          = 2000
    session_redis_host                     = "127.0.0.1"
    session_redis_port                     = 6379
    session_redis_read_timeout             = 2000
    session_redis_send_timeout             = 2000
    session_redis_ssl                      = false
    session_redis_ssl_verify               = false
    session_remember                       = false
    session_remember_absolute_timeout      = 2592000
    session_remember_cookie_name           = "remember"
    session_remember_rolling_timeout       = 604800
    session_rolling_timeout                = 3600
    session_storage                        = "cookie"
    session_store_metadata                 = false
    session_strategy                       = "default"
    ssl_verify                             = false
    timeout                                = 10000
    tls_client_auth_ssl_verify             = true
    token_cache_key_include_scope          = false
    unauthorized_destroy_session           = true
    unauthorized_error_message             = "Unauthorized"
    upstream_access_token_header           = "authorization:bearer"
    userinfo_accept                        = "application/json"
    using_pseudo_issuer                    = false
    verify_claims                          = true
    verify_nonce                           = true
    verify_parameters                      = false
    verify_signature                       = true
  }
  enabled = true
  protocols = [
    "grpc",
    "grpcs",
    "http",
    "https"
  ]
  control_plane_id = var.control_plane_id
  service          = { id = konnect_gateway_service.Kassongo_service.id }
}
