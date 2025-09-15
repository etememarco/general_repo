resource "konnect_gateway_service" "Kassongo_service" {
  connect_timeout  = 60000
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
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
  write_timeout    = 60000
}

resource "konnect_gateway_route" "Kassongo_route" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
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
    id = "d1c2d6a0-8eb8-4cf8-97d1-81c9d28c1ff9"
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}


resource "konnect_gateway_service" "mocky_service" {
  connect_timeout  = 9
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"  
  name     = "mocky_service"
  host     = "run.mocky.io"
  protocol = "https"
  port     = 443
  tls_verify = true
  read_timeout    = 30
  write_timeout   = 10
}

resource "konnect_gateway_route" "mocky_route" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  name          = "mocky_route"
  service       = { id = konnect_gateway_service.mocky_service.id }
  hosts         = ["mocky"]
  paths         = ["/anything"]
  protocols     = ["http","https"]
  strip_path    = true
  preserve_host = false
}

resource "konnect_gateway_service" "echo_service" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  name     = "echo_service"
  host     = "postman-echo.com"
  protocol = "https"
  port     = 443
  tls_verify = true
}

# Route exposée publiquement
resource "konnect_gateway_route" "echo_route" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  name             = "echo_route"
  service       = { id = konnect_gateway_service.echo_service.id }
  paths            = ["/anything"]
  protocols        = ["http", "https"]
  strip_path       = true
  preserve_host    = false
  https_redirect_status_code = 307
  hosts            = ["echo.com"]
}


resource "konnect_gateway_service" "httpbun" {
  connect_timeout  = 60000
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
  created_at       = 10
  enabled          = true
  host             = "httpbun.com"
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
  write_timeout    = 60000
}

resource "konnect_gateway_route" "payload" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
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
    id = "c61de38a-d659-4fda-a42e-23554437f0b7"
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_route" "run" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
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
    id = "c61de38a-d659-4fda-a42e-23554437f0b7"
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}

resource "konnect_gateway_route" "mix" {
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
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
    id = "c61de38a-d659-4fda-a42e-23554437f0b7"
  }
  strip_path = true
  tags = [
    "env: uat"
  ]
}
resource "konnect_gateway_upstream" "httpbun" {
  algorithm = "round-robin"
  hash_fallback = "none"
  hash_on = "none"
  hash_on_cookie_path = "/"
  healthchecks = {
    active = {
      concurrency = 10
      healthy = {
        http_statuses = [
          200,
          302
        ]
        interval = 0
        successes = 0
      }
      http_path = "/"
      https_verify_certificate = true
      timeout = 1
      type = "http"
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
        interval = 0
        tcp_failures = 0
        timeouts = 0
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
        timeouts = 0
      }
    }
    threshold = 0
  }
  name = "httpbun.com"
  slots = 10000
  sticky_sessions_cookie_path = "/"
  use_srv_name = false
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
}


resource "konnect_gateway_upstream" "httpbin" {
  algorithm = "round-robin"
  hash_fallback = "none"
  hash_on = "none"
  hash_on_cookie_path = "/"
  healthchecks = {
    active = {
      concurrency = 10
      healthy = {
        http_statuses = [
          200,
          302
        ]
        interval = 0
        successes = 0
      }
      http_path = "/"
      https_verify_certificate = true
      timeout = 1
      type = "http"
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
        interval = 0
        tcp_failures = 0
        timeouts = 0
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
        timeouts = 0
      }
    }
    threshold = 0
  }
  host_header = "httpbin.konghq.com"
  name = "httpbin"
  slots = 10000
  sticky_sessions_cookie_path = "/"
  use_srv_name = false
  control_plane_id = "0caf752c-a73a-47fe-b0c7-e5ae03abe5cc"
}
