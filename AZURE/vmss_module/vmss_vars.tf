variable resource_g_name {}
variable location {}
variable vmss_name {}
variable sku {}
variable "admin_username" {}
variable ssh_pub_key_name {}
variable ssh_key_resource_group {}
variable storage_account_type {}
variable network_interface_name {}
variable zones { type=list}
variable vmss_subnet_id {}
variable minimum_instances { type=number }
variable maximum_instances { type= number }
variable application_protocol {}
variable application_port { type=number }
variable path_to_health_check {}
variable app_lb_backend_pool_id {
    type = set(string)
}