data "azurerm_ssh_public_key" "ssh_pub_key"{
    name = var.ssh_pub_key_name
    resource_group_name = var.ssh_key_resource_group
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
    name = var.vmss_name
    resource_group_name = var.resource_g_name
    location = var.location
    sku = var.sku
    admin_username = var.admin_username
    # secure_boot_enabled = true
    upgrade_mode = "Automatic"
    custom_data = base64encode(file("./vmss_module/custom_data.sh"))

    admin_ssh_key {
        public_key = data.azurerm_ssh_public_key.ssh_pub_key.public_key
        username = var.admin_username
    }

    zones = var.zones

    source_image_reference {
        publisher = "canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts"
        version = "latest"
    }

    os_disk {
        storage_account_type = var.storage_account_type
        caching = "ReadWrite"
    }

    network_interface {
        name = var.network_interface_name
        primary = true
        ip_configuration {
            name = "internal"
            primary = true
            version = "IPv4"
            subnet_id = var.vmss_subnet_id
            application_gateway_backend_address_pool_ids = var.app_lb_backend_pool_id
            # public_ip_address {
            #   name = "myapp_ip"
            # }
        }

    }

    automatic_os_upgrade_policy {
        disable_automatic_rollback = false
        enable_automatic_os_upgrade = true
    }

    extension {
      name = "ApplicationHealthExtension"
      publisher = "Microsoft.ManagedServices"
      type = "ApplicationHealthLinux"
      type_handler_version = "1.0"
      auto_upgrade_minor_version = false

      settings = jsonencode({
        protocol = "${var.application_protocol}"
        port = "${var.application_port}"
        requestPath = "${var.path_to_health_check}"
      })
    }

}

resource "azurerm_monitor_autoscale_setting" "autoscaling_policy" {
    name = "AutoscalingPolicy"
    resource_group_name = var.resource_g_name
    location = var.location
    target_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
    enabled = true

    profile {
        name = "mainProfile"

        capacity {
            default = var.minimum_instances
            minimum = var.minimum_instances
            maximum = var.maximum_instances
        }

        rule {
            metric_trigger {
            metric_name        = "Percentage CPU"
            metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
            time_grain         = "PT1M"
            statistic          = "Average"
            time_window        = "PT5M"
            time_aggregation   = "Average"
            operator           = "GreaterThan"
            threshold          = 75
            metric_namespace   = "microsoft.compute/virtualmachinescalesets"
            }

            scale_action {
            direction = "Increase"
            type = "ChangeCount"
            value = "1"
            cooldown = "PT1M"
            }
        }

        rule {
            metric_trigger {
                metric_name        = "Percentage CPU"
                metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
                time_grain         = "PT1M"
                statistic          = "Average"
                time_window        = "PT5M"
                time_aggregation   = "Average"
                operator           = "LessThan"
                threshold          = 25
            }

            scale_action {
                direction = "Decrease"
                type      = "ChangeCount"
                value     = "1"
                cooldown  = "PT1M"
            }
        }
    }
}