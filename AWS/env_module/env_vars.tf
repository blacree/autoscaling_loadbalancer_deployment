locals {
  env = terraform.workspace

  env_type = {
    default = "default"
    staging = "staging"
    production = "production"
  }

  ami_id ={
    default = ""
    staging = ""
    production = ""
  }

  instance_type = {
    default = ""
    staging = ""
    production = ""
  }

  vpc_id = {
    default = ""
    staging = ""
    production = ""
  }

  subnet_ids = {
    # You must provide at least 2 subnets
    default = ["", ""]
    staging = []
    production = []
  }

  as_group_desired = {
    default = 1
    staging = 1
    production = 2
  }

  as_group_min = {
    default = 1
    staging = 1
    production = 2
  }

  as_group_max = {
    default = 2
    staging = 2
    production = 4
  }
}

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