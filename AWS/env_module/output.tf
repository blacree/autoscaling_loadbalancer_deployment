output env_type {
    value = lookup(local.env_type, local.env)
}

output ami_id {
    value = lookup(local.ami_id, local.env)
}

output instance_type {
    value = lookup(local.instance_type, local.env)
}

output vpc_id {
    value = lookup(local.vpc_id, local.env)
}

output subnet_ids {
    value = lookup(local.subnet_ids, local.env)
}

output as_group_desired{
    value = lookup(local.as_group_desired, local.env)
}

output as_group_min {
    value = lookup(local.as_group_min, local.env)
}

output as_group_max {
    value = lookup(local.as_group_max, local.env)
}