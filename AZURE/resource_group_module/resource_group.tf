variable resource_g_name {}
variable location {}

resource "azurerm_resource_group" "app_lb_resource_g" {
    name = var.resource_g_name
    location = var.location
}

output "resource_g_name" {
    value = azurerm_resource_group.app_lb_resource_g.name
}