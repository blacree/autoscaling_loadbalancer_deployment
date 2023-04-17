# Autoscaling_Loadbalancer_Application_Deployment
Application Deployment using Autoscaling and Application Loadbalancer with Environment configuration (default, staging and production)

## AWS
User supplied Vars and Env config @
- AWS/terraform.tfvars
- AWS/env_module/env.tf

Configure your Application using bash @
- AWS/autoscaling_module/userdata.sh


## AZURE
User supplied Vars and Env config @
- AZURE/terraform.tfvars
- AZURE/env_module/env.tf

Configure your Application using bash @
- AZURE/vmss_module/custom_data.sh


## GCP
*Coming*



#### Note: The environment used corresponds to the name of your Terraform Workspace which should be 'default', 'staging' or 'production'