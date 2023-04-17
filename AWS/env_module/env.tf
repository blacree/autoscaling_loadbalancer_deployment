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