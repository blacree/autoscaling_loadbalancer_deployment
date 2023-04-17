resource "aws_autoscaling_group" "main_autoscaling_group" {
    name = var.ag_name
    desired_capacity = var.desired_size
    min_size = var.min_size
    max_size = var.max_size
    health_check_grace_period = 300
    health_check_type = "ELB"
    force_delete = false
    launch_configuration = aws_launch_configuration.launch_config.name
    vpc_zone_identifier = var.subnet_ids
    target_group_arns = [var.target_group_arn]

    tag {
        key = "Name"
        value = var.ag_name
        propagate_at_launch = true
    }

    tag {
      key = "Environment"
      value = var.env_tag
      propagate_at_launch = true
    }
}

resource "aws_launch_configuration" "launch_config"{
    name = "Launch config - ${var.ag_name}"
    image_id = var.image_id
    instance_type = var.instance_type
    key_name = var.key_name
    user_data = file("autoscaling_module/userdata.sh")
    security_groups = [var.security_group_id]
}