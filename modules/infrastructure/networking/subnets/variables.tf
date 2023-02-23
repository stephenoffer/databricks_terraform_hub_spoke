variable resource_prefix {}

variable resource_group_name {}

variable location {}

variable "vnet_address_space" {}

variable "public_subnet_cidr" {}

variable "private_subnet_cidr" {}

variable "endpoint_subnet_cidr" {}

variable "tags" {
  description = "Tags"
  type        = map(string)
}