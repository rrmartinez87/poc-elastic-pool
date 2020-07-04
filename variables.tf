/*
  Input variable definitions to create an Azure SQL Single Database resource and its dependences
*/

//--- Common variables
//--------------------
variable "resource_group" { 
    description = "The name of the resource group in which to create the database server. This must be the same as the resource group of the underlying SQL server."
    type = string
}

variable "location" { 
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
    type = string
}

variable "tags" { 
    description = "A mapping of tags to assign to the resource."
    type = map
}


//--- Database server variables
//-----------------------------
variable "create_database_server" { 
    description = "Flag that indicates whether the database server should be created or not."
    type = bool
    default = true
}

variable "server_name" { 
    description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
    type = string
}

variable "server_admin_login"  { 
    description = "The administrator login name for the new server. Changing this forces a new resource to be created."
    type = string
}

variable "server_admin_password"  { 
    description = "The administrator password for the new server, required when create_server_admin_secret is true"
    type = string
    default = null
}

variable "create_server_admin_secret"  { 
    description = "The administrator login name for the new server. Changing this forces a new resource to be created."
    type = bool
    default = false
}

variable "server_admin_key_vault_secret_name" { 
    description = "Name of the secret in Azure Key Vault where admin password is kept."
    type = string
}

variable "server_admin_key_vault_id" { 
    description = "Azure Key Vault ID where the secret is stored."
    type = string
}

variable "azuread_admin_login"  { 
    description = "The login username of the Azure AD Administrator of this SQL Server."
    type = string
}

variable "azuread_admin_object_id"  { 
    description = "The object id of the Azure AD Administrator of this SQL Server."
    type = string
}

variable "azuread_admin_tenant_id"  { 
    description = "The tenant id of the Azure AD Administrator of this SQL Server."
    type = string
    default = null
}


//--- Logging/auditing storage account variables
//-----------------------------------------------
variable "auditing_storage_account_name" { 
    description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
    type = string
}

variable "auditing_storage_account_tier" { 
    description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
    type = string
}

variable "auditing_storage_account_replication_type" { 
    description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
    type = string
}

variable "storage_account_access_key_is_secondary" { 
    description = "Specifies whether storage_account_access_key value is the storage's secondary key."
    type = bool
}

variable "retention_in_days" { 
    description = "Specifies the number of days to retain logs for in the storage account. A value of 0 means unlimited."
    type = number
}


//--- Advance Data Security (ADS) variables
//-----------------------------------------------
variable "advanced_data_security_storage_account_name" { 
    description = " Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
    type = string
}

variable "advanced_data_security_storage_account_tier" { 
    description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
    type = string
}

variable "advanced_data_security_storage_account_replication_type" { 
    description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
    type = string
}

variable "advanced_data_security_storage_container_name" { 
    description = "The name of the Container which should be created within the Storage Account."
    type = string
}

variable "threat_protection_email_addresses" { 
    description = "Specifies an array of e-mail addresses to which the alert is sent."
    type = list(string)
}

variable "vulnerability_assessment_email_addresses" { 
    description = "Specifies an array of e-mail addresses to which the scan notification is sent."
    type = list(string)
}


//--- Elastic pool variables
//------------------------------
variable "elastic_pool_name" { 
    description = "The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created."
    type = string
}

variable "max_size_gb" { 
    description = "The max data size of the elastic pool in gigabytes."
    type = number
}

variable "license_type" { 
    description = "Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
    type = string
}

variable "zone_redundant" { 
    description = "Whether or not this elastic pool is zone redundant. Tier needs to be Premium for DTU based or BusinessCritical for vCore based sku. Defaults to false"
    type = bool
    default = false
}


//--- Service tier (SKU) variables
variable "sku_name" { 
    description = "Specifies the SKU Name for this Elasticpool. The name of the SKU, will be either vCore based tier + family pattern (e.g. GP_Gen4, BC_Gen5) or the DTU based BasicPool, StandardPool, or PremiumPool pattern."
    type = string
}

variable "sku_tier" { 
    description = "The tier of the particular SKU. Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, or Premium."
    type = string
}

variable "sku_capacity" { 
    description = "The scale up/out capacity, representing server's compute units (DTUs or vCores)."
    type = number
}

variable "sku_family" { 
    description = "The family of hardware Gen4 or Gen5."
    type = string
    default = null
}


//--- Per database variables
variable "db_settings_min_capacity" { 
    description = "The minimum capacity all databases are guaranteed."
    type = number
}

variable "db_settings_max_capacity" { 
    description = "The maximum capacity any one database can consume."
    type = number
}


//--- Private endopoint variables
//--------------------------------
variable "vnet_resource_group" { 
    description = "The name of the resource group in which exists the vnet/subnet where to set network policies disabled."
    type = string
}

variable "subnet_id" {
    description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
    type = string
}

variable "private_endpoint_name" {
    description = "Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created."
    type = string
}

variable "private_service_connection_name" {
    description = "Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created."
    type = string
    default = "sql_server_private_service_connection_name"
}


//--- Private DNS zone variables
//-------------------------------
variable "private_dns_zone_name" {
    description = "The name of the Private DNS Zone. Must be a valid domain name."
    type = string
    default = "privatelink.database.windows.net"
}

variable "private_dns_zone_vnet_link_name" {
    description = "The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created."
    type = string
    default = "private_dns_zone_vnet_link"
}

variable "vnet_id" {
    description = "The Resource ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
    type = string
}

variable "private_dns_zone_config_name" {
    description = "Name of the resource that is unique within a resource group. This name can be used to access the resource."
    type = string
    default = "private_dns_zone_config_name"
}

variable "private_dns_zone_group_name" {
    description = "The name of the private dns zone group."
    type = string
    default = "private_dns_zone_group_name"
}


//--- Virtual Network/Subnet variables
//-------------------------------------
variable "create_vnet" { 
    description = "Flag to indicate whether vnet/subnet should be created or not."
    type = bool
}

variable "vnet_name" {
    description = "The name of the virtual network. Changing this forces a new resource to be created."
    type = string
}

variable "vnet_address_space" {
    description = "The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
    type = string
}

variable "subnet_name" {
    description = "The name of the subnet. Changing this forces a new resource to be created."
    type = string
}

variable "subnet_address_prefixes" {
    description = "The address prefixes to use for the subnet."
    type = list(string)
}