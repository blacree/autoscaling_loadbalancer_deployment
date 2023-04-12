# Autoscaling_Loadbalancer_Application_Deployment
Application Deployment using Autoscaling and Application Loadbalancer with Environment configuration (default, staging and production)

## AWS
User supplied Vars and Env config @
- AWS/terraform.tfvars
- AWS/env_module/env_vars.tf

Configure your Application using bash @
- AWS/autoscaling_module/userdata.sh


## AZURE
*Coming*


## GCP
*Coming*



#### Note: The environment used corresponds to the name of your Terraform Workspace which should be 'default', 'staging' or 'production'