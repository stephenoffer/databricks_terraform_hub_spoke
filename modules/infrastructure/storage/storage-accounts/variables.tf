variable storage_prefix {
    type = string 
}

variable resource_group_name {
    type = string 
}

variable location {
    type = string
}

variable storage_container_name {
    type = string 
}

variable subnet_ids {
    type = list(string)
}

variable principal_id {
    type = string 
}

variable tags {
    type = map(string)
}