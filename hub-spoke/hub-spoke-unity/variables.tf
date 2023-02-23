variable "metastore_id" {
  type        = string
  description = "ID of metastore that is manually created in corresponding region"
}

variable "unity_catalog_user_group" {
  type        = string
  description = "User group that will be given default permissions on all UC resources (e.g., catalogs, schemas)"
  default     = "databricks"
}

variable "storage_credential_id" {
  type        = string
  description = "The id of the storage credential created in the Databricks account console. Note that this credential id corresponds to the access contector that is created by Terraform."
}
