# vmss variables
variable admin_username {}
variable ssh_pub_key_name {}
variable ssh_key_resource_group {}
variable network_interface_name {}

# Application vars
variable application_protocol {}
variable application_port { type=number }
variable application_path_to_health_check {}
variable application_main_page_path {}
variable https_application { type=bool }

# Public Ip vars
variable public_ip_name {}

# Application Loadbalancer vars
variable app_lb_name {}
variable app_lb_port { type=number }
variable cookie-based-affinity {}