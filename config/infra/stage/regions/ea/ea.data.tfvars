# Resource naming 
prefix      = "databricks"
location    = "eastasia"
region      = "ea"
env         = "stage"

spoke_vnet_address_space   = ["", ""]
spoke_public_subnet_cidr   = ""
spoke_private_subnet_cidr  = ""
spoke_endpoint_subnet_cidr = ""

# Storage 
storage_container_name               = "data"
unity_catalog_storage_container_name  = "uc-data"

# Secrets 
secret_scope_name = "db-scope-kv"
