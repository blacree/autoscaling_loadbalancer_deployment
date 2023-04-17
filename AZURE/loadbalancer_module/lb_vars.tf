variable app_lb_name {}
variable resource_g_name {}
variable location {}
variable minimum_instances {}
variable maximum_instances {}
variable public_ip_id {}
variable lb_subnet_id {}
variable app_lb_port { type=number }
variable application_port { type=number }
variable cookie-based-affinity {}
variable application_main_page_path {}
variable ssl_key_vault_secret_id {}
variable https_application { type=bool }
variable "zones" { type=list }

variable "gateway_ip_config_name"{
    default = "lb-gateway"
}

variable frontend_port_name{
    default = "main-port"
}

variable frontend_ip_configuration_name{
    default = "main-ip-config"
}

variable "backend_address_pool_name" {
    default = "main-backend-pool"
}

variable "backend_http_settings_name" {
    default = "main-backend-settings"
}

variable "http_listener_name"{
    default = "main-http-listener"
}

variable "routing_table_name"{
    default = "main-routing-table"
}

variable "route_priority"{
    type = number
    default = 1
}

variable "ssl_certificate_name"{
    default = "main-ssl-certificate"
}