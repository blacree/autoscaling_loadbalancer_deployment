# application gateway resource for http application
resource "azurerm_application_gateway" "http_app_gateway_lb" {
    count = var.https_application ? 0 : 1
    name = var.app_lb_name
    resource_group_name = var.resource_g_name
    location = var.location

    sku {
      name = "Standard_v2"
      tier = "Standard_v2"
    }

    gateway_ip_configuration {
        name = var.gateway_ip_config_name
        subnet_id = var.lb_subnet_id
    }

    frontend_port {
        name = var.frontend_port_name
        port = var.app_lb_port
    }

    frontend_ip_configuration {
      name = var.frontend_ip_configuration_name
      public_ip_address_id = var.public_ip_id
    }

    backend_address_pool {
        name = var.backend_address_pool_name
    }

    backend_http_settings {
      name = var.backend_http_settings_name
      cookie_based_affinity = var.cookie-based-affinity
      path = var.application_main_page_path
      port = var.application_port
      protocol = "Http"
      request_timeout = 60
    }

    http_listener {
      name = var.http_listener_name
      frontend_ip_configuration_name = var.frontend_ip_configuration_name
      frontend_port_name = var.frontend_port_name
      protocol = "Http"
    }

    request_routing_rule {
      name = var.routing_table_name
      rule_type = "Basic"
      http_listener_name = var.http_listener_name
      backend_address_pool_name = var.backend_address_pool_name
      backend_http_settings_name = var.backend_http_settings_name
      priority = var.route_priority
    }

    autoscale_configuration {
      min_capacity = var.minimum_instances
      max_capacity = var.maximum_instances
    }

    zones = var.zones

}

resource "azurerm_application_gateway" "https_app_gateway_lb" {
    count = var.https_application ? 1 : 0
    name = var.app_lb_name
    resource_group_name = var.resource_g_name
    location = var.location

    sku {
      name = "Standard_v2"
      tier = "Standard_v2"
    }

    gateway_ip_configuration {
        name = var.gateway_ip_config_name
        subnet_id = var.lb_subnet_id
    }

    frontend_port {
        name = var.frontend_port_name
        port = var.app_lb_port
    }

    frontend_ip_configuration {
      name = var.frontend_ip_configuration_name
      public_ip_address_id = var.public_ip_id
    }

    backend_address_pool {
        name = var.backend_address_pool_name
    }

    backend_http_settings {
      name = var.backend_http_settings_name
      cookie_based_affinity = var.cookie-based-affinity
      path = var.application_main_page_path
      port = var.application_port
      protocol = "Https"
      request_timeout = 60
    }

    ssl_certificate {
      name = var.ssl_certificate_name
      key_vault_secret_id = var.ssl_key_vault_secret_id
    }

    http_listener {
      name = var.http_listener_name
      frontend_ip_configuration_name = var.frontend_ip_configuration_name
      frontend_port_name = var.frontend_port_name
      protocol = "Https"
      ssl_certificate_name = var.ssl_certificate_name
    }

    request_routing_rule {
      name = var.routing_table_name
      rule_type = "Basic"
      http_listener_name = var.http_listener_name
      backend_address_pool_name = var.backend_address_pool_name
      backend_http_settings_name = var.backend_http_settings_name
      priority = var.route_priority
    }

    autoscale_configuration {
      min_capacity = var.minimum_instances
      max_capacity = var.maximum_instances
    }

    zones = var.zones

}

output "backend_pool_id" {
  value = toset([
    for pool in concat(
      [for pool in try(azurerm_application_gateway.http_app_gateway_lb[0].backend_address_pool, []) : pool],
      [for pool in try(azurerm_application_gateway.https_app_gateway_lb[0].backend_address_pool, []) : pool]
    ) : pool.id
    if pool.id != null
  ])
}