//--- Common variables
//---------------------
resource_group = "rg-sql-elastic-pool2"
location = "westus2"
tags = {
    environment = "dev"
    product = "mvp"
    sql_type = "elastic"
}


//--- Database server variables
//------------------------------
server_name = "yuma-sqlsvr-rafael"
server_admin_login = "yuma-sqlusr"
create_server_admin_secret = false
server_admin_password = "Passw0rd"
server_admin_key_vault_secret_name = "sqlsvr-admin"
server_admin_key_vault_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-support/providers/Microsoft.KeyVault/vaults/yuma-keys"
azuread_admin_login = "rafael.martinez@globant.com"
azuread_admin_object_id = "adc78f07-0628-4143-aa66-3b69bf3ff237"
azuread_admin_tenant_id = null

//--- Server logging/auditing variables
auditing_storage_account_name = "yumaauditingstgacc3"
auditing_storage_account_tier = "Standard"
auditing_storage_account_replication_type = "LRS"
storage_account_access_key_is_secondary = false
retention_in_days = 0

//--- Advanced Data Security (ADS) variables
advanced_data_security_storage_account_name = "yumaadsstgacc3"
advanced_data_security_storage_account_tier = "Standard"
advanced_data_security_storage_account_replication_type = "LRS"
advanced_data_security_storage_container_name = "yumaadsstgcon"
threat_protection_email_addresses = ["rafael.martinez@globant.com"]
vulnerability_assessment_email_addresses = ["rafael.martinez@globant.com"]


//--- Elastic pool variables
//------------------------------
elastic_pool_name = "yuma-elastic"
max_size_gb = 50 // oblig para basic
license_type = "BasePrice"
zone_redundant = false

// Service tier settings
sku_name = "StandardPool"//"GP_Gen5"
sku_tier = "Standard"
sku_capacity = 50
sku_family = null //oblig para gc y bc

// Per database settings
db_settings_min_capacity = 10
db_settings_max_capacity = 10


//--- VNet/Subnet
//----------------
create_vnet = true
vnet_name = "vnet-endpoint"
vnet_address_space = "10.0.0.0/16"
subnet_name = "subnet-endpoint"
subnet_address_prefixes = ["10.0.1.0/24"]


//--- Private Endpoint variables
//-------------------------------
vnet_resource_group = "rg-sql-single-database3"
private_endpoint_name = "private-endpoint"
subnet_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-support/providers/Microsoft.Network/virtualNetworks/vnet-endpoint/subnets/subnet-endpoint"
private_service_connection_name = "any_optional_name"
vnet_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-support/providers/Microsoft.Network/virtualNetworks/vnet-endpoint"

//--- DNS configuration
private_dns_zone_name = "privatelink.database.windows.net"
private_dns_zone_vnet_link_name = "private_dsn_zone_vnet_link"
private_dns_zone_config_name = "private_dns_zone_config_name"
private_dns_zone_group_name = "private_dns_zone_group_name"
