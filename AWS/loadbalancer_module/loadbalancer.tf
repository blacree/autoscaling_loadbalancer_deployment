resource "aws_lb" "main_loadbalancer" {
    name = var.lb_name
    internal = false
    load_balancer_type = "application"
    security_groups = [var.lb_sg_id]
    subnets = var.subnet_ids
    enable_deletion_protection = false

    tags = {
        Environment = "${var.env_tag}"
    }
}


resource "aws_lb_target_group" "lb_target_group"{
    name = "${var.lb_name}-Target-Group"
    port = var.application_port
    protocol = var.protocol_name
    vpc_id = var.vpc_id
}

resource "aws_lb_listener" "http_forward" {
    load_balancer_arn = aws_lb.main_loadbalancer.arn
    port = var.application_port
    protocol = var.protocol_name
    # ssl_policy = "ELBSecurityPolicy-2016-08"
    # certificate_arn = 

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.lb_target_group.arn
    }
}

output "target_group_arn" {
    value = aws_lb_target_group.lb_target_group.arn
}

output lb_dns {
    value = aws_lb.main_loadbalancer.dns_name
}