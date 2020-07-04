//--- Set Terraform API version
terraform {
  required_version = ">=0.12.0"
}


//--- Set Azure provider configuration
provider "azurerm" {
    version = "=2.13.0"
    subscription_id = "a265068d-a38b-40a9-8c88-fb7158ccda23"
    features {}
}


//--- Azure resource group definition
resource "azurerm_resource_group" "rg" {

    name = var.resource_group
    location = var.location
    tags = var.tags
}


//--- Create Azure SQL logical database server by using module
module "database_server" {

    source = "./modules/database_server"

    // Set module parameters
    resource_group = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    server_name = var.server_name
    tags = var.tags

    // Server and AAD users configuration
    server_admin_login = var.server_admin_login
    create_server_admin_secret = var.create_server_admin_secret
    server_admin_password = var.server_admin_password
    server_admin_key_vault_secret_name = var.server_admin_key_vault_secret_name
    server_admin_key_vault_id = var.server_admin_key_vault_id
    azuread_admin_login = var.azuread_admin_login
    azuread_admin_object_id  = var.azuread_admin_object_id
    azuread_admin_tenant_id = var.azuread_admin_tenant_id

    // Logging/auditing parameters
    auditing_storage_account_name = var.auditing_storage_account_name
    auditing_storage_account_tier = var.auditing_storage_account_tier
    auditing_storage_account_replication_type = var.auditing_storage_account_replication_type
    storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary 
    retention_in_days = var.retention_in_days

    // Advanced Data Security (ADS) settings
    advanced_data_security_storage_account_name = var.advanced_data_security_storage_account_name
    advanced_data_security_storage_account_tier = var.advanced_data_security_storage_account_tier
    advanced_data_security_storage_account_replication_type = var.advanced_data_security_storage_account_replication_type
    advanced_data_security_storage_container_name = var.advanced_data_security_storage_container_name
    threat_protection_email_addresses = var.threat_protection_email_addresses
    vulnerability_assessment_email_addresses = var.vulnerability_assessment_email_addresses
}


//--- Create Azure SQL Elastic Pool by using module
module "elastic_pool" {

    source = "./modules/elastic_pool"

    // Set module parameters
    elastic_pool_name = var.elastic_pool_name
    resource_group = var.resource_group
    location = var.location
    server_name = module.database_server.server_name
    max_size_gb = var.max_size_gb
    license_type = var.license_type
    zone_redundant = var.zone_redundant
    tags = var.tags
 
    // Service tier settings
    sku_name = var.sku_name
    sku_tier = var.sku_tier
    sku_capacity = var.sku_capacity
    sku_family = var.sku_family

    // Elastic pool per database settings
    db_settings_min_capacity = var.db_settings_min_capacity
    db_settings_max_capacity = var.db_settings_max_capacity
}


//--- Create virtual network/subnet to set up private endpoint
module "virtual_network" {

    source = "./modules/virtual_network"

    // Set module parameters
    create_vnet = var.create_vnet
    resource_group = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    tags = var.tags
    vnet_name = var.vnet_name
    vnet_address_space = var.vnet_address_space
    subnet_name = var.subnet_name
    subnet_address_prefixes = var.subnet_address_prefixes
}


//--- Create Private Endpoint
module "private_endpoint" {

    source = "./modules/private_endpoint"

    // Set module parameters
    resource_group = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    tags = var.tags

    // Endpoint configuration
    vnet_resource_group = var.vnet_resource_group
    private_endpoint_name = var.private_endpoint_name
    subnet_id = var.create_vnet ? module.virtual_network.subnet_id : var.subnet_id
    private_service_connection_name = var.private_service_connection_name
    database_server_id = module.database_server.server_id
    vnet_id = var.create_vnet ? module.virtual_network.vnet_id : var.vnet_id
    
    // DNS configuration
    private_dns_zone_name = var.private_dns_zone_name
    private_dns_zone_vnet_link_name = var.private_dns_zone_vnet_link_name
    private_dns_zone_config_name = var.private_dns_zone_config_name
    private_dns_zone_group_name = var.private_dns_zone_group_name
}