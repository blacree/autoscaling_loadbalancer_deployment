# vmss - virtual machine scale set | lb = loadbalancer

module "env_module"{
    source = "./env_module"
}

module "resource_group_module" {
    source = "./resource_group_module"
    resource_g_name = module.env_module.resource_group_name
    location = module.env_module.location
}

module "ip_module" {
    source = "./IP_module"
    resource_g_name = module.resource_group_module.resource_g_name
    location = module.env_module.location
    public_ip_name = var.public_ip_name
    zones = module.env_module.zones

    depends_on = [
      module.resource_group_module
    ]
}


module "loadbalancer_module" {
    source = "./loadbalancer_module"
    app_lb_name = var.app_lb_name
    resource_g_name = module.resource_group_module.resource_g_name
    location = module.env_module.location
    maximum_instances = module.env_module.maximum_instances
    minimum_instances = module.env_module.minimum_instances
    public_ip_id = module.ip_module.public_ip_id
    lb_subnet_id = module.env_module.lb_subnet_id
    app_lb_port = var.app_lb_port
    application_port = var.application_port
    cookie-based-affinity = var.cookie-based-affinity
    application_main_page_path = var.application_main_page_path
    ssl_key_vault_secret_id = module.env_module.ssl_key_vault_secret_id
    zones = module.env_module.zones
    https_application = var.https_application

    depends_on = [
        module.ip_module
    ]
}

module "vmss" {
    source = "./vmss_module"
    vmss_name = module.env_module.vmss_name
    resource_g_name = module.resource_group_module.resource_g_name
    location = module.env_module.location
    sku = module.env_module.sku
    admin_username = var.admin_username
    storage_account_type = module.env_module.storage_account_type
    zones = module.env_module.zones
    network_interface_name = var.network_interface_name
    vmss_subnet_id = module.env_module.vmss_subnet_id
    ssh_key_resource_group = var.ssh_key_resource_group
    ssh_pub_key_name = var.ssh_pub_key_name
    maximum_instances = module.env_module.maximum_instances
    minimum_instances = module.env_module.minimum_instances
    application_protocol = var.application_protocol
    application_port = var.application_port
    path_to_health_check = var.application_path_to_health_check
    app_lb_backend_pool_id = module.loadbalancer_module.backend_pool_id
}

# Note:
# - The Network Security Group of the subnet for your VMSS must allow inbound access for your vmss inbound port and this port must match the port your application exposes
# - The Network Security Group of the Subnet for your LoadBalancer must allow inbound access for the application LB's port
# - The Network Security Group of the subnet for your LoadBalancer must also allow TCP inbound access on port range 65200-65535