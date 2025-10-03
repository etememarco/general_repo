resource "konnect_gateway_service" "Kassongo_service" {
  connect_timeout  = 60000
  control_plane_id = var.control_plane_id
  created_at       = 10
  enabled          = true
  host             = "httpbin.org"
  name             = "Kassongo_service"
  port             = 443
  protocol         = "https"
  read_timeout     = 60000
  retries          = 5
  tags = [
    "env: uat"
  ]
  # tls_verify       = true
  # tls_verify_depth = 8
  write_timeout = 60000
}

resource "konnect_gateway_route" "Kassongo_route_anything" {
  control_plane_id = var.control_plane_id
  hosts = [
    "example.com"
  ]
  https_redirect_status_code = 307
  methods = [
    "GET",
  ]
  name          = "kassongo_route"
  path_handling = "v0"
  paths = [
    "/anything"
  ]
  preserve_host = false
  protocols = [
    "http", "https"
  ]
  regex_priority     = 9
  request_buffering  = true
  response_buffering = true
  service = {
    id = var.kassongo_service_id
  }

  strip_path          = true
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_route" "Kassongo_route_bearer" {
  control_plane_id = var.control_plane_id
  hosts = [
    "example.com"
  ]
  https_redirect_status_code = 307
  methods = [
    "GET",
  ]
  name          = "kassongo_bearer"
  path_handling = "v0"
  paths = [
    "/bearer"
  ]
  preserve_host = false
  protocols = [
    "http", "https"
  ]
  regex_priority      = 9
  request_buffering   = true
  response_buffering  = true
  service = {
    id = var.kassongo_service_id
  }
  strip_path          = true
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_service" "httpbun" {
  connect_timeout  = 60000
  control_plane_id = var.control_plane_id
  created_at       = 10
  enabled          = true
  host             = "httpbun"
  name             = "httpbun"
  port             = 443
  protocol         = "https"
  read_timeout     = 60000
  retries          = 5
  tags = [
    "env: uat"
  ]
  # tls_verify       = true
  # tls_verify_depth = 8
  write_timeout = 60000
}

resource "konnect_gateway_route" "payload" {
  control_plane_id = var.control_plane_id
  hosts = [
    "kong.com"
  ]
  https_redirect_status_code = 307
  methods = [
    "GET",
  ]
  name          = "payload"
  path_handling = "v0"
  paths = [
    "/payload"
  ]
  preserve_host = false
  protocols = [
    "http", "https"
  ]
  regex_priority     = 9
  request_buffering  = true
  response_buffering = true
  service = {
    id = var.httpbun_id
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_route" "run" {
  control_plane_id = var.control_plane_id
  hosts = [
    "kong.com"
  ]
  https_redirect_status_code = 307
  methods = [
    "GET",
  ]
  name          = "run"
  path_handling = "v0"
  paths = [
    "/run"
  ]
  preserve_host = false
  protocols = [
    "http", "https"
  ]
  regex_priority     = 9
  request_buffering  = true
  response_buffering = true
  service = {
    id = var.httpbun_id
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_route" "mix" {
  control_plane_id = var.control_plane_id
  hosts = [
    "kong.com"
  ]
  https_redirect_status_code = 307
  methods = [
    "GET",
  ]
  name          = "mix"
  path_handling = "v0"
  paths = [
    "/mix"
  ]
  preserve_host = false
  protocols = [
    "http", "https"
  ]
  regex_priority     = 9
  request_buffering  = true
  response_buffering = true
  service = {
    id = var.httpbun_id
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}
resource "konnect_gateway_upstream" "httpbun" {
  algorithm           = "round-robin"
  host_header         = "httpbun.com"
  hash_fallback       = "none"
  hash_on             = "none"
  hash_on_cookie_path = "/"
  healthchecks = {
    active = {
      concurrency = 10
      healthy = {
        http_statuses = [
          200,
          302
        ]
        interval  = 0
        successes = 0
      }
      http_path                = "/"
      https_verify_certificate = true
      timeout                  = 1
      type                     = "http"
      unhealthy = {
        http_failures = 0
        http_statuses = [
          429,
          404,
          500,
          501,
          502,
          503,
          504,
          505
        ]
        interval     = 0
        tcp_failures = 0
        timeouts     = 0
      }
    }
    passive = {
      healthy = {
        http_statuses = [
          200,
          201,
          202,
          203,
          204,
          205,
          206,
          207,
          208,
          226,
          300,
          301,
          302,
          303,
          304,
          305,
          306,
          307,
          308
        ]
        successes = 0
      }
      type = "http"
      unhealthy = {
        http_failures = 0
        http_statuses = [
          429,
          500,
          503
        ]
        tcp_failures = 0
        timeouts     = 0
      }
    }
    threshold = 0
  }
  name                        = "httpbun"
  slots                       = 10000
  sticky_sessions_cookie_path = "/"
  use_srv_name                = false
  control_plane_id            = var.control_plane_id
}


resource "konnect_gateway_upstream" "httpbin" {
  algorithm           = "round-robin"
  hash_fallback       = "none"
  hash_on             = "none"
  hash_on_cookie_path = "/"
  healthchecks = {
    active = {
      concurrency = 10
      healthy = {
        http_statuses = [
          200,
          302
        ]
        interval  = 0
        successes = 0
      }
      http_path                = "/"
      https_verify_certificate = true
      timeout                  = 1
      type                     = "http"
      unhealthy = {
        http_failures = 0
        http_statuses = [
          429,
          404,
          500,
          501,
          502,
          503,
          504,
          505
        ]
        interval     = 0
        tcp_failures = 0
        timeouts     = 0
      }
    }
    passive = {
      healthy = {
        http_statuses = [
          200,
          201,
          202,
          203,
          204,
          205,
          206,
          207,
          208,
          226,
          300,
          301,
          302,
          303,
          304,
          305,
          306,
          307,
          308
        ]
        successes = 0
      }
      type = "http"
      unhealthy = {
        http_failures = 0
        http_statuses = [
          429,
          500,
          503
        ]
        tcp_failures = 0
        timeouts     = 0
      }
    }
    threshold = 0
  }
  host_header                 = "httpbin.konghq.com"
  name                        = "httpbin"
  slots                       = 10000
  sticky_sessions_cookie_path = "/"
  use_srv_name                = false
  control_plane_id            = var.control_plane_id
}
