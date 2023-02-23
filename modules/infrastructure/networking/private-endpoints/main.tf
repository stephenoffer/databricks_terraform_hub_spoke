resource azurerm_private_endpoint "storage-endpoint" {
    name                = "${var.region}-private-endpoint"
    location            = var.location
    resource_group_name = var.resource_group_name
    subnet_id           = var.subnet_id
    tags                = var.tags

    private_service_connection {
        name                           = "${var.region}-service-connection"
        is_manual_connection           = false
        private_connection_resource_id = var.storage_account_id
        subresource_names              = ["dfs"]
    }
}

resource "azurerm_private_dns_a_record" "dns_a_record" {
    name                = var.storage_account_name
    zone_name           = "privatelink.dfs.core.windows.net"
    resource_group_name = var.resource_group_name
    ttl                 = 300
    records             = [azurerm_private_endpoint.storage-endpoint.private_service_connection[0].private_ip_address]
}