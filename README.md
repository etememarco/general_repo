# 📘 Documentation: Deploying APIs on **Kong Konnect** with **Terraform**

## 1️⃣ Introduction
**Terraform** is an Infrastructure as Code (IaC) tool that allows you to:
- Describe your infrastructure using text files (`.tf`)
- Automate the deployment and configuration of services
- Version-control your infrastructure as code using Git
- Ensure reproducibility and consistency across environments (dev, UAT, prod)

**Kong Konnect** is an API management platform that enables you to:
- Expose your backend services through API gateways
- Configure routes and upstreams for traffic management
- Apply plugins to secure, limit, or enhance your APIs
- Manage consumers and consumer groups for access control

This documentation explains how to use **Terraform** to automate:
- The creation of **services** and **routes**
- The configuration of **upstreams**
- The creation of **consumers** and **consumer groups**
- The activation of **security and control plugins**

## 2️⃣ Prerequisites
Before starting, make sure you have:
- Terraform installed (v1.5 or higher)
  ```bash
  terraform version
  ```
- A **Kong Konnect account** with a **Personal Access Token**
- A **Git project** to version your Terraform files
- Network access to the services exposed by Kong

### Environment variables for Terraform (local setup)
```bash
export TF_VAR_konnect_personal_access_token="your_token"
export TF_VAR_control_plane_id="your_control_plane_id"
```

## 3️⃣ Terraform Variables
To secure credentials and passwords, use **sensitive variables** like this:
```hcl
variable "client_id" {
  type      = string
  sensitive = true
}
variable "client_secret" {
  type      = string
  sensitive = true
}
```
These variables ensure secrets remain hidden in Terraform logs and Git.

## 4️⃣ Deploying Services
**Services** represent the backend APIs exposed through Kong.
Example:
```hcl
resource "konnect_gateway_service" "Kassongo_service" {
  control_plane_id = var.control_plane_id
  name             = "Kassongo_service"
  host             = "httpbin.org"
  port             = 443
  protocol         = "https"
  enabled          = true
  connect_timeout  = 60000
  read_timeout     = 60000
  write_timeout    = 60000
  retries          = 5
  tags             = ["env: uat"]
}
```

## 5️⃣ Deploying Routes
**Routes** define how HTTP/HTTPS requests are forwarded to services.
```hcl
resource "konnect_gateway_route" "Kassongo_route_anything" {
  control_plane_id = var.control_plane_id
  name             = "kassongo_route"
  paths            = ["/anything"]
  methods          = ["GET"]
  protocols        = ["http", "https"]
  preserve_host    = false
  service = {
    id = var.kassongo_service_id
  }
  strip_path = true
  tags       = ["env: uat"]
}
```

## 6️⃣ Upstreams
**Upstreams** enable load balancing across multiple backend instances.
```hcl
resource "konnect_gateway_upstream" "httpbun" {
  name                        = "httpbun"
  host_header                 = "httpbun.com"
  algorithm                   = "round-robin"
  slots                       = 10000
  sticky_sessions_cookie_path = "/"
  control_plane_id            = var.control_plane_id
  use_srv_name                = false
}
```

## 7️⃣ Consumers and Groups
**Consumers:**
```hcl
resource "konnect_gateway_consumer" "kassongo_user" {
  control_plane_id = var.control_plane_id
  username         = "Kassongo"
  tags             = ["env: uat"]
}
```
**Consumer Groups:**
```hcl
resource "konnect_gateway_consumer_group" "kassongo_group" {
  control_plane_id = var.control_plane_id
  name             = "kassongo_group"
  tags             = ["env: uat"]
}
```

## 8️⃣ Plugins
### Key Auth
```hcl
resource "konnect_gateway_plugin_key_auth" "gateway_plugin_keyauth" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = false
  protocols = ["https"]
  config = {
    key_names   = ["apikey"]
    key_in_header = true
  }
}
```

### Basic Auth
```hcl
resource "konnect_gateway_plugin_basic_auth" "kassongo_basic_auth" {
  service  = { id = konnect_gateway_service.Kassongo_service.id }
  enabled  = true
  protocols = ["http", "https"]
}
```

### ACL
```hcl
resource "konnect_gateway_plugin_acl" "kassongo_acl" {
  service  = { id = konnect_gateway_service.Kassongo_service.id }
  enabled  = true
  protocols = ["http", "https", "grpc", "grpcs"]
  config = {
    deny = ["paiya_group"]
  }
}
```

### Rate Limiting
```hcl
resource "konnect_gateway_plugin_rate_limiting_advanced" "gateway_plugin_rate_limiting_advanced" {
  service  = { id = konnect_gateway_service.Kassongo_service.id }
  enabled  = true
  protocols = ["http", "https"]
  config = {
    identifier  = "ip"
    limit       = [100]
    window_size = [3600]
  }
}
```

## 9️⃣ Terraform Commands
### terraform init
Initializes the Terraform project.

### terraform plan
Prepares and displays the execution plan.

### terraform apply
Applies configuration to deploy/update infrastructure.

### terraform destroy
Destroys all managed resources.

## 🔒 Best Practices
- Always run `terraform plan` before `apply`.
- Never commit `terraform.tfstate` or `.terraform/`.
- Use workspaces for different environments (dev, uat, prod).
- Store secrets in sensitive variables.
- Test on UAT before production.
