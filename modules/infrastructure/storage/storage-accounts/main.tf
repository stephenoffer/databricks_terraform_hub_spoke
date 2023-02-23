resource "azurerm_storage_account" "this" {
    name                            = "${var.storage_prefix}sa"
    resource_group_name             = var.resource_group_name
    location                        = var.location
    account_tier                    = "Standard"
    account_replication_type        = "LRS"
    public_network_access_enabled   = true
    allow_nested_items_to_be_public = false 
    is_hns_enabled                  = true 

    tags = var.tags 

}

resource "azurerm_storage_container" "this" {
    name                  = var.storage_container_name 
    storage_account_name  = azurerm_storage_account.this.name
    container_access_type = "private"
}


resource "azurerm_role_assignment" "access_connector_assignment" { 
    scope                = azurerm_storage_account.this.id
    role_definition_name = "Storage Blob Data Contributor"
    principal_id         = var.principal_id 
}