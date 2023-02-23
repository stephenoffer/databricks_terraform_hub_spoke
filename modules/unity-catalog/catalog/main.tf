locals {
  external_location_path = format("abfss://%s@%s.dfs.core.windows.net/",
    var.storage_container_name,
  var.storage_account_name)
}


resource "databricks_external_location" "external_location" {
  name = "${var.prefix}-external"
  url = local.external_location_path
  credential_name = var.storage_credential_id
  comment         = "Managed by TF"
}

resource "databricks_grants" "external_location" {
  external_location = databricks_external_location.external_location.id
  grant {
    principal  = var.user_group
    privileges = ["READ_FILES", "WRITE_FILES", "CREATE_EXTERNAL_TABLE"]
  }
}

resource "databricks_catalog" "catalog" {
  metastore_id = var.metastore_id
  name         = var.catalog_name
  storage_root = "${local.external_location_path}${databricks_external_location.external_location.name}"
}

resource "databricks_grants" "catalog" {
  catalog = databricks_catalog.catalog.name
  grant {
    principal  = var.user_group
    privileges = ["USE_CATALOG", "USE_SCHEMA", "CREATE_SCHEMA", "CREATE_TABLE", "MODIFY"]
  }
}

resource "databricks_schema" "default" {
  catalog_name = databricks_catalog.catalog.name 
  name = "default"
}

resource "databricks_grants" "schema" {
  schema = databricks_schema.default.id
  grant {
    principal = var.user_group
    privileges = ["USE_SCHEMA", "SELECT", "MODIFY", "CREATE_TABLE", "CREATE_VIEW"]
  }
}

