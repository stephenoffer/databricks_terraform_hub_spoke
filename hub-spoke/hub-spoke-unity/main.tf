terraform {
  backend "azurerm" {
    resource_group_name  = "<RESOURCE_GROUP>"
    storage_account_name = "<STORAGE_NAME>"
    container_name       = "<STORAGE_CONTAINER_NAME>"
    key                  = "<KEY>"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.38.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.9.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "infra" {
  backend = "azurerm"
  config = {
    resource_group_name  = "<RESOURCE_GROUP>"
    storage_account_name = "<STORAGE_NAME>"
    container_name       = "<STORAGE_CONTAINER_NAME>"
    key                  = "<KEY>"
  }
}

provider "databricks" {
  host = data.terraform_remote_state.infra.outputs.workspace_host
}

module "hub-catalog" {

  source = "../../modules/unity-catalog/catalog"

  metastore_id            = var.metastore_id
  access_connector_id     = data.terraform_remote_state.infra.outputs.access_connector_id
  storage_credential_id   = var.storage_credential_id
  databricks_workspace_id = data.terraform_remote_state.infra.outputs.workspace_id
  storage_account_name    = data.terraform_remote_state.infra.outputs.hub_storage_account_name
  storage_container_name  = data.terraform_remote_state.infra.outputs.hub_storage_container_name
  catalog_name            = "hub_catalog"
  user_group              = var.unity_catalog_user_group
  prefix = "hub"

}

module "spoke-catalog" {

  source = "../../modules/unity-catalog/catalog"

  metastore_id            = var.metastore_id
  access_connector_id     = data.terraform_remote_state.infra.outputs.access_connector_id
  storage_credential_id   = var.storage_credential_id
  databricks_workspace_id = data.terraform_remote_state.infra.outputs.workspace_id
  storage_account_name    = data.terraform_remote_state.infra.outputs.spoke_storage_account_name
  storage_container_name  = data.terraform_remote_state.infra.outputs.spoke_storage_container_name
  catalog_name            = "spoke_catalog"
  user_group              = var.unity_catalog_user_group
  prefix = "spoke" 

}
