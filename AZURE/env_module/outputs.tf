output "resource_group_name" {
    value = lookup(local.resource_group, local.env)
}

output "location"{
    value = lookup(local.location, local.env)
}

output "vmss_name" {
    value = lookup(local.vmss_name, local.env)
}

output "sku" {
    value = lookup(local.sku, local.env)
}

output "storage_account_type"{
    value = lookup(local.storage_account_type, local.env)
}

output "zones" {
    value = lookup(local.zones, local.env)
}

output "vmss_subnet_id"{
    value = lookup(local.vmss_subnet_id, local.env)
}

output "minimum_instances"{
    value = lookup(local.minimum_no_instances, local.env)
}

output "maximum_instances" {
    value = lookup(local.maximum_no_instances, local.env)
}

output "lb_subnet_id"{
    value = lookup(local.lb_subnet_id, local.env)
}

output "ssl_key_vault_secret_id"{
    value = lookup(local.ssl_key_vault_secret_id, local.env)
}