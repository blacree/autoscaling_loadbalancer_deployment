# Do not pass values here. Pass your values in terraform.tfvars file

# Declare secrutiy group vars 
variable lb_sg_name {}
variable ag_sg_name {}
variable lb_sg_description {}
variable ag_sg_description {}

# Declare autoscaling group vars
variable ag_name {}
variable key_name {}

# Declare loadbalancer vars
variable lb_name {}

# Declare LB and AG vars
variable application_port {}
variable "protocol_name" {}