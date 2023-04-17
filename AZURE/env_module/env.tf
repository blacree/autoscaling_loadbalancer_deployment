locals {
    env = terraform.workspace

    resource_group = {
        default = ""
        staging = ""
        production = ""
    }

    location = {
        default = "East US"
        staging = ""
        production = ""
    }

    # VMSS varibles
    vmss_name = {
        default = ""
        staging = ""
        production = ""
    }

    sku = {
        default = "Standard_B1s"
        staging = ""
        production = ""
    }

    storage_account_type = {
        default = "StandardSSD_LRS"
        staging = ""
        production = ""
    }

    zones = {
        default = ["1", "2", "3"]
        staging = []
        production = []
    }

    vmss_subnet_id = {
        # Note: subnet must be in the location (region) as configured for your deployment
        default = ""
        staging = ""
        production = ""
    }

    # Configure the minimum and maximum no of instances for your specific application use-case
    minimum_no_instances = {
        default = 2
        staging = 2
        production = 2
    }

    maximum_no_instances = {
        default = 3
        staging = 3
        production = 3
    }

    # Application LB vars
    lb_subnet_id = {
        # Note: - The subnet you select must be used for your Application Loadbalancer alone
        # - The subnet you choose for your LB must be in the same virtual-network as that of your vmss subnet and if not it must have proper route access to the subnet of your vmss
        default = ""
        staging = ""
        production = ""
    }

    # Only set this option if your application is an https application. Store the base-64 encoded unencrypted pfx file in your key vault.
    # Note: You need to enable soft delete for keyvault to use this feature
    ssl_key_vault_secret_id = {
        default = ""
        staging = ""
        production = ""
    }
}