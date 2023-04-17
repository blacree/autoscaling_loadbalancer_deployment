module "env_module"{
    source = "./env_module"
}

module "security_group_module" {
    source = "./security_group_module"
    lb_sg_name = var.lb_sg_name
    ag_sg_name = var.ag_sg_name
    lb_sg_description = var.lb_sg_description
    ag_sg_description = var.ag_sg_description
    vpc_id = module.env_module.vpc_id
    application_port = var.application_port
    protocol_name = var.protocol_name
}

module "loadbalancer_module" {
    source = "./loadbalancer_module"
    lb_name = var.lb_name
    lb_sg_id = module.security_group_module.lb_sg_id
    subnet_ids = module.env_module.subnet_ids
    vpc_id = module.env_module.vpc_id
    env_tag = module.env_module.env_type
    application_port = var.application_port
    protocol_name = var.protocol_name

    depends_on = [
      module.security_group_module
    ]
}

module "autoscaling_module" {
    source = "./autoscaling_module"
    ag_name = var.ag_name
    key_name = var.key_name
    desired_size = module.env_module.as_group_desired
    min_size = module.env_module.as_group_min
    max_size = module.env_module.as_group_max
    image_id = module.env_module.ami_id
    instance_type = module.env_module.instance_type
    subnet_ids = module.env_module.subnet_ids
    env_tag = module.env_module.env_type
    security_group_id = module.security_group_module.ag_sg_id
    target_group_arn = module.loadbalancer_module.target_group_arn

    depends_on = [
        module.loadbalancer_module
    ]
}

output "loadbalancer_dns_name"{
    value = "Your DNS Address: ${module.loadbalancer_module.lb_dns}:${var.application_port}"
}