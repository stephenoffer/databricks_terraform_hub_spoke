variable "prefix" {
  description = "Prefix used to name all resources"
}

variable "location" {
  description = "Location of the resource group."
}

variable "region" {
  description = "Name of the region"
}

variable "env" {
  description = "Name of the environment"
}

variable "spoke_vnet_address_space" {}

variable "spoke_public_subnet_cidr" {}

variable "spoke_private_subnet_cidr" {}

variable "spoke_endpoint_subnet_cidr" {}

variable "secret_scope_name" {
  type    = string
  default = "default"
}

variable "storage_container_name" {
  description = "Storage Container Name"
}

variable "unity_catalog_storage_container_name" {
  description = "Storage Unity Catalog Container Name"
}
