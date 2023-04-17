resource "azurerm_public_ip" "app_public_ip"{
    name = var.public_ip_name
    resource_group_name = var.resource_g_name
    location = var.location
    allocation_method = "Static"
    sku = "Standard"
    zones = var.zones
}

output "public_ip_id"{
    value = azurerm_public_ip.app_public_ip.id
}