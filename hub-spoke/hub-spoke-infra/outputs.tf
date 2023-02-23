output access_connector_id {
    value       = module.databricks-access-connector.access_connector_id
    description = "ID for the Databricks Access Connector to be used with Unity Catalog"
}

output workspace_id {
    value = azurerm_databricks_workspace.spoke-workspace.workspace_id
    description = "ID for the Hub Databricks Workspace"
}

output workspace_host {
    value = azurerm_databricks_workspace.spoke-workspace.workspace_url
    description = "Workspace URL for the Hub Databricks Workspace"
}

output hub_storage_account_name {
    value = module.hub-storage.storage_account_name
    description = "Storage account name used for the hub external location"
}

output hub_storage_account_id {
    value = module.hub-storage.storage_account_id
    description = "Storage account id used for the hub external storage location"
}

output hub_storage_container_name {
    value = module.hub-storage.storage_container_name
    description = "Storage account container used for the hub external location of Unity Catalog"
}

output spoke_storage_account_name {
    value = module.spoke-storage.storage_account_name
    description = "Storage account name used for the spoke external location"
}

output spoke_storage_account_id {
    value = module.spoke-storage.storage_account_id
    description = "Storage account id used for the spoke external storage location"
}

output spoke_storage_container_name {
    value = module.spoke-storage.storage_container_name
    description = "Storage account container used for the spoke external location of Unity Catalog"
}