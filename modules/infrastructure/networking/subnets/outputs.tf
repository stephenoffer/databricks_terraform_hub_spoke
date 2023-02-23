output subnet_ids {
    value = [azurerm_subnet.public.id, azurerm_subnet.private.id]
    description = "List of the subnet ids for the public and private Databricks workspace subnets"
}

output vnet_id {
    value = azurerm_virtual_network.this.id
    description = "ID for the virtual network created"
}

output public_subnet_name {
    value = azurerm_subnet.public.name
    description = "Name of the public subnet created for Databricks workspace"
}

output public_subnet_id {
    value = azurerm_subnet.public.id
    description = "ID of the public subnet created for Databricks workspace. Also used to for the public_subnet_network_security_group_association_id"
}

output private_subnet_name {
    value = azurerm_subnet.private.name 
    description = "name of the private subnet created for Databricks workspace"
}

output private_subnet_id {
    value = azurerm_subnet.private.id
    description = "ID of the private subnet created for Databricks workspace. Also used to for the private_subnet_network_security_group_association_id"
}

output endpoint_subnet_id {
    value = azurerm_subnet.endpoint-subnet.id
    description = "ID of the subnet used to host private endpoints"
}