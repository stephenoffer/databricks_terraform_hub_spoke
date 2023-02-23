output storage_account_id {
    value = azurerm_storage_account.this.id
    description = "Id of the storage account created"
}

output storage_account_name {
    value = azurerm_storage_account.this.name
    description = "Name of the storage account created"
}

output storage_container_name {
    value = azurerm_storage_container.this.name
    description = "Name of default container created"
}