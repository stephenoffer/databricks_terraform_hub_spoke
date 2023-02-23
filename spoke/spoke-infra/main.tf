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
      version = "1.7.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  spoke_resource_prefix = "${var.prefix}-spoke-${var.env}-${var.region}"
  storage_prefix        = "${var.prefix}${var.env}${var.region}"

  tags = {
    Purpose     = "SharedResource"
    Application = "ApiInfraSpoke"
    CreatedBy   = "Terraform"
    Env         = var.env
  }
}

resource "azurerm_resource_group" "spoke_rg" {
  name     = "${local.spoke_resource_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "databricks-access-connector" {

  source = "../../modules/infrastructure/storage/storage-connector"

  connector_name      = "${local.spoke_resource_prefix}-mi"
  resource_group_name = azurerm_resource_group.spoke_rg.name
  location            = azurerm_resource_group.spoke_rg.location
  tags                = local.tags
}

module "spoke-networking" {
  source = "../../modules/infrastructure/networking/subnets/"

  # Setup 
  resource_prefix     = local.spoke_resource_prefix
  resource_group_name = azurerm_resource_group.spoke_rg.name
  location            = azurerm_resource_group.spoke_rg.location

  # Networking 
  vnet_address_space   = var.spoke_vnet_address_space
  public_subnet_cidr   = var.spoke_public_subnet_cidr
  private_subnet_cidr  = var.spoke_private_subnet_cidr
  endpoint_subnet_cidr = var.spoke_endpoint_subnet_cidr

  # Storage 

  tags = local.tags

}

module "spoke-storage" {
  source = "../../modules/infrastructure/storage/storage-accounts/"

  storage_prefix      = local.storage_prefix
  resource_group_name = azurerm_resource_group.spoke_rg.name
  location            = azurerm_resource_group.spoke_rg.location

  storage_container_name = var.storage_container_name
  subnet_ids             = module.spoke-networking.subnet_ids
  principal_id           = module.databricks-access-connector.principal_id

  tags = local.tags
}

module "unity-catalog-storage" {
  source = "../../modules/infrastructure/storage/storage-accounts/"

  storage_prefix      = "${local.storage_prefix}uc"
  resource_group_name = azurerm_resource_group.spoke_rg.name
  location            = azurerm_resource_group.spoke_rg.location

  storage_container_name = var.unity_catalog_storage_container_name
  subnet_ids             = module.spoke-networking.subnet_ids
  principal_id           = module.databricks-access-connector.principal_id

  tags = local.tags
}

resource "azurerm_databricks_workspace" "spoke-workspace" {
  name                          = "${local.spoke_resource_prefix}-dbw"
  resource_group_name           = azurerm_resource_group.spoke_rg.name
  location                      = azurerm_resource_group.spoke_rg.location
  sku                           = "premium"
  public_network_access_enabled = true
  tags                          = local.tags
  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = module.spoke-networking.vnet_id
    public_subnet_name                                   = module.spoke-networking.public_subnet_name
    public_subnet_network_security_group_association_id  = module.spoke-networking.public_subnet_id
    private_subnet_name                                  = module.spoke-networking.private_subnet_name
    private_subnet_network_security_group_association_id = module.spoke-networking.private_subnet_id
  }
}


# Secret Scope 

provider "databricks" {
  host                        = azurerm_databricks_workspace.spoke-workspace.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.spoke-workspace.id

  azure_use_msi = true 
}

resource "databricks_secret_scope" "this" {
  name = "default-scope"
}
