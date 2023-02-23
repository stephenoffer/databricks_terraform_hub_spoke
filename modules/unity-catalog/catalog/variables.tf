variable prefix {
    type = string 
    description = "Prefix for external location name"
}

variable metastore_id {
    type = string 
    description = "Metastore id. Must be manually created by a Databricks Account Admin and added to terraform.tfvars "
}

variable access_connector_id {
    type = string 
    description = "The id of the access connector that was created by Terraform"
}

variable storage_credential_id {
    type = string 
    description = "The id of the storage credential that is manually created in the Databricks Account Console"
}
variable databricks_workspace_id {
    type = string 
    description = "The id of the workspace we want to attach to the Unity Catalog metastore"
}

variable storage_account_name {
    type = string 
    description = "The name of the storage account used for an external location"
}

variable storage_container_name {
    type = string 
    description = "The name of the storage account container used for an external location"
}

variable catalog_name {
    type = string
    description = "Name of the catalog to create"
    default = "default"
}

variable user_group {
    type = string 
    description = "The default user group that will have permission on the external location"
}