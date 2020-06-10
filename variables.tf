/*
  Input variable definitions for an Azure SQL elastic pool resource and its dependences
*/

// Variables to indicate whether some resources should be created or not
variable "create_resource_group" {
    description = "Flag indicating whether the resource group must be created or use existing"
    type = bool
    default = true
}

variable "create_database_server" {
    description = "Flag indicating whether the database server must be created or use existing"
    type = bool
    default = true
}

// Common variables definition
variable "resource_group_name" { 
    description = "The name of the resource group in which to create the elastic pool. This must be the same as the resource group of the underlying SQL server."
    type = string
    default = "rg-sql-elastic-poc"
}

variable "location" { 
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
    type = string
    default = "westus2"
}

variable "tags" { 
    description = "A mapping of tags to assign to the resource."
    type = map
    default = {
        environment = "development"
        product_type = "poc"
    }
}

// Database server variables
variable "server_name" { 
    description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
    type = string
    default = "sql-db-server"
}

variable "server_version" { 
    description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
    type = string
    default = "12.0"
}

variable "administrator_login"  { 
    description = "The administrator login name for the new server. Changing this forces a new resource to be created."
    type = string
    default = "yuma-user"
}

variable "administrator_login_password" { 
    description = "The password associated with the administrator_login user. Needs to comply with Azure's Password Policy."
    type = string
    default = "_Adm123$"
}

// Elastic pool variables
variable "elastic_pool_name" { 
    description = "The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created."
    type = string
    default = "yuma-elastic"
}

variable "sku_name" { 
    description = "Specifies the SKU Name for this Elasticpool."
    type = string
    default = "GP_Gen5"
}

variable "sku_tier" { 
    description = "The tier of the particular SKU. Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, or Premium."
    type = string
    default = "GeneralPurpose"
}

variable "sku_capacity" { 
    description = "The scale up/out capacity, representing server's compute units."
    type = number
    default = 2
}

variable "sku_family" { 
    description = "The family of hardware Gen4 or Gen5"
    type = string
    default = "Gen5"
}

variable "db_settings_min_capacity" { 
    description = "The max data size of the elastic pool in gigabytes. Conflicts with"
    type = number
    default = 0
}

variable "db_settings_max_capacity" { 
    description = "The max data size of the elastic pool in gigabytes. Conflicts with"
    type = number
    default = 2
}

variable "max_size_gb" { 
    description = "The max size of the database in gigabytes."
    type = number
    default = 5
}

// Single database variables
variable "single_database_name" { 
    description = "The name of the Ms SQL Database. Changing this forces a new resource to be created."
    type = string
    default = "yuma-singledb"
}

variable "service_tier" { 
    description = "The id of the Ms SQL Server on which to create the database. Changing this forces a new resource to be created."
    type = string
    default = "Basic"
}

variable "single_max_size_gb" { 
    description = "The max size of the database in gigabytes."
    type = number
    default = 2
}

// Virtual network variables
variable "vnet_name" {
    description = "The name of the virtual network. Changing this forces a new resource to be created."
    type = string
    default = "vnet"
}

variable "vnet_address_space" {
    description = "The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
    type = string
    default = "10.0.0.0/16"
}

// Subnet variables
variable "subnet_name" {
    description = "The name of the subnet. Changing this forces a new resource to be created."
    type = string
    default = "subnet"
}

variable "subnet_address_prefixes" {
    description = "The address prefixes to use for the subnet."
    type = list(string)
    default     = ["10.0.1.0/24"]
}

// Private endopoint variables
variable "private_endpoint_name" {
    description = "Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created."
    type = string
    default = "private-endpoint"
}

variable "service_connection_name" {
    description = "Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created."
    type = string
    default = "service_connection_name" 
}

variable "requires_manual_approval" {
    description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
    type = bool
    default = false 
}

// Private DNS zone variables
variable "private_dns_zone_name" {
    description = "The name of the Private DNS Zone. Must be a valid domain name."
    type = string
    default = "privatelink.database.windows.net"  
}

variable "private_dns_zone_vnet_link" {
    description = "The name of the Private DNS Zone. Must be a valid domain name."
    type = string
    default = "private_dns_zone_vnet_link"  
}
