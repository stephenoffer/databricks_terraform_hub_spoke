output "access_connector_id" {
  value       = module.databricks-access-connector.access_connector_id
  description = "ID for the Databricks Access Connector to be used with Unity Catalog"
}

output "workspace_id" {
  value       = azurerm_databricks_workspace.spoke-workspace.workspace_id
  description = "ID for the Databricks Workspace"
}

output "workspace_host" {
  value = azurerm_databricks_workspace.spoke-workspace.workspace_url
}

output "storage_account_name" {
  value       = module.spoke-storage.storage_account_name
  description = "Storage account name used for the external location of Unity Catalog"
}

output "storage_account_id" {
  value       = module.spoke-storage.storage_account_id
  description = "Storage accoutn id used for the external storage location"
}

output "storage_container_name" {
  value       = module.spoke-storage.storage_container_name
  description = "Storage account container used for the external location of Unity Catalog"
}
