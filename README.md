**Documentation : Déploiement d’APIs sur Kong Konnect avec Terraform**



1️⃣ **Introduction**

Terraform est un outil d’Infrastructure as Code (IaC) qui permet de :

- Décrire votre infrastructure sous forme de fichiers texte (.tf)

- Automatiser le déploiement et la configuration des services

- Versionner votre infrastructure comme du code dans Git

- Garantir la reproductibilité et la cohérence entre les environnements (dev, UAT, prod)


Kong Konnect est une plateforme de gestion d’APIs qui permet de :

- Exposer vos services via des gateways

- Configurer des routes et des upstreams pour le trafic

- Appliquer des plugins pour sécuriser, limiter ou enrichir vos APIs

- Gérer des consumers et des groupes de consumers pour le contrôle d’accès

- Cette documentation explique comment utiliser Terraform pour automatiser :

- La création de services et routes

- La configuration d’upstreams

- La création de consumers et de groupes

- L’activation de plugins de sécurité et de contrôle



2️⃣ **Prérequis**

Avant de commencer, vous devez avoir :

Terraform installé (v1.5 ou plus)

terraform version


Un compte Kong Konnect avec un Personal Access Token

Un projet Git pour versionner vos fichiers Terraform

Accès réseau aux services exposés par Kong

Variables d’environnement configurées pour Terraform en local :

- export TF_VAR_konnect_personal_access_token="votre_token"
- export TF_VAR_control_plane_id="votre_control_plane_id"


3️⃣ ***Variables Terraform***

Pour sécuriser les identifiants et mots de passe, il faut utiliser des variables sensibles sous cette forme  :

variable "client_id" {
  type      = string
  sensitive = true
}

variable "client_secret" {
  type      = string
  sensitive = true
}



***Ces variables permettent de masquer les secrets dans Terraform et Git.***


4️⃣ ***Déploiement des Services***

Les services représentent les APIs backend exposées par Kong.

Exemple : Service Kassongo
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

Exemple : Service Httpbun
resource "konnect_gateway_service" "httpbun" {
  control_plane_id = var.control_plane_id
  name             = "httpbun"
  host             = "httpbun"
  port             = 443
  protocol         = "https"
  enabled          = true
  connect_timeout  = 60000
  read_timeout     = 60000
  write_timeout    = 60000
  retries          = 5
  tags             = ["env: uat"]
}


5️⃣ ***Déploiement des Routes***

Les routes définissent comment les requêtes HTTP/HTTPS sont acheminées vers les services.

resource "konnect_gateway_route" "Kassongo_route_anything" {
  control_plane_id = var.control_plane_id
  name             = "kassongo_route"
  paths            = ["/anything"]
  methods          = ["GET"]
  protocols        = ["http", "https"]
  preserve_host    = false
  service = { id = var.kassongo_service_id }
  strip_path       = true
  tags             = ["env: uat"]
}


Répétez pour chaque route (/bearer, /payload, /run, /mix).

Chaque route est liée à un service.



6️⃣ ***Upstreams***

Les upstreams permettent le load balancing entre plusieurs instances backend.

resource "konnect_gateway_upstream" "httpbun" {
  name             = "httpbun"
  host_header      = "httpbun.com"
  algorithm        = "round-robin"
  slots            = 10000
  sticky_sessions_cookie_path = "/"
  control_plane_id = var.control_plane_id
  use_srv_name     = false
}

7️⃣ ***Consumers et Groupes***
Consumers
resource "konnect_gateway_consumer" "kassongo_user" {
  control_plane_id = var.control_plane_id
  username         = "Kassongo"
  tags             = ["env: uat"]
}


Créez tous vos consumers (demo-user, katika, atalaku) de la même façon.

Consumer Groups
resource "konnect_gateway_consumer_group" "kassongo_group" {
  control_plane_id = var.control_plane_id
  name             = "kassongo_group"
  tags             = ["env: uat"]
}

resource "konnect_gateway_consumer_group_member" "kassongo_group_member" {
  consumer_group_id = konnect_gateway_consumer_group.kassongo_group.id
  consumer_id       = var.consumer_kassongo_id
  control_plane_id  = var.control_plane_id
}


Les groupes permettent de grouper les consumers pour appliquer des ACL.

8️⃣ ***Plugins***
Key Auth
resource "konnect_gateway_plugin_key_auth" "gateway_plugin_keyauth" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = false
  protocols = ["https"]
  config = {
    key_names = ["apikey"]
    key_in_header = true
  }
}

Basic Auth
resource "konnect_gateway_plugin_basic_auth" "kassongo_basic_auth" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = true
  protocols = ["http","https"]
}

ACL
resource "konnect_gateway_plugin_acl" "kassongo_acl" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = true
  protocols = ["http","https","grpc","grpcs"]
  config = { deny = ["paiya_group"] }
}

Rate Limiting
resource "konnect_gateway_plugin_rate_limiting_advanced" "gateway_plugin_rate_limiting_advanced" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = true
  protocols = ["http","https"]
  config = {
    identifier = "ip"
    limit      = [100]
    window_size = [3600]
  }
}

Proxy Cache
resource "konnect_gateway_plugin_proxy_cache_advanced" "proxy_cache_advanced" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = true
  protocols = ["http","https","grpc","grpcs"]
  config = { strategy = "memory", cache_ttl = 300 }
}

OpenID Connect
resource "konnect_gateway_plugin_openid_connect" "openid_connect" {
  service = { id = konnect_gateway_service.Kassongo_service.id }
  enabled = true
  protocols = ["http","https","grpc","grpcs"]
  config = {
    client_id       = [var.client_id]
    client_secret   = [var.client_secret]
    issuer          = var.issuer
    scopes          = ["openid"]
    scopes_required = ["kassongo:read","kassongo:write"]
  }
}

9️⃣ ***Bonnes pratiques***

- Stockez les secrets dans des variables Terraform.

- Versionnez vos fichiers dans Git pour garantir la traçabilité.

- Testez d’abord sur un environnement UAT.

- Organisez services, consumers et plugins par environnement (uat, prod).

- Activez uniquement les plugins nécessaires pour optimiser les performances.

- Toujours garder le Terraform state hors du repo git distant pour éviter d'exposer les valeurs sensibles => commandes pour les supprimer sur github mais les garder en local : 
git rm --cached terraform.tfstate
git rm --cached terraform.tfstate.backup

