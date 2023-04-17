# vmss variables
admin_username = "" # Admin username for your spawned instances
# Store your ssh pub key in an SSH key Storage (Service: SSH Key)
ssh_pub_key_name = ""   # Name of existing ssh public key stored in your ssh key storage
ssh_key_resource_group = "" # Resource group name where the ssh key is located
network_interface_name = "" # Network interface name

# Application vars
application_protocol = "http"   # Must match either "http" OR "https"
application_port = 80   # This is your VMSS port and the port exposed by your application.
application_path_to_health_check = "/"  # Your application webpage path to query for health check
application_main_page_path = "/"
https_application = false   # Boolean to determine type of application. Set to "true" if your application_protocol is "https"

# Public Ip vars
public_ip_name = ""

# Application Loadbalancer Settings
app_lb_name = ""
app_lb_port = 80    # Port that would be exposed by your application loadbalancer    
cookie-based-affinity = "Disabled" # Options: Disabled | Enabled