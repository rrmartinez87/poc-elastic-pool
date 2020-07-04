//--- Common variables
//---------------------
resource_group = "rg-sql-elastic-pool"
location = "westus2"
tags = {
    environment = "dev"
    product = "mvp"
    sql_type = "elastic"
}


//--- Database server variables
//------------------------------
server_name = "yuma-sqlsvr"
server_admin_login = "yuma-sqlusr"
create_server_admin_secret = false
server_admin_password = "Passw0rd"
server_admin_key_vault_secret_name = "sqlsvr-admin"
server_admin_key_vault_id = "/subscriptions/a265068d-a38b-40a9-8c88-fb7158ccda23/resourceGroups/rg-sql-support/providers/Microsoft.KeyVault/vaults/yuma-keys2"
azuread_admin_login = "juanmauricio.garzon@globant.com"
azuread_admin_object_id = "7b1a20dd-eaad-4b76-abbf-c170410f6b46"
azuread_admin_tenant_id = null

//--- Server logging/auditing variables
auditing_storage_account_name = "yumaauditingstgacc"
auditing_storage_account_tier = "Standard"
auditing_storage_account_replication_type = "LRS"
storage_account_access_key_is_secondary = false
retention_in_days = 0

//--- Advanced Data Security (ADS) variables
advanced_data_security_storage_account_name = "yumaadsstgacc"
advanced_data_security_storage_account_tier = "Standard"
advanced_data_security_storage_account_replication_type = "LRS"
advanced_data_security_storage_container_name = "yumaadsstgcon"
threat_protection_email_addresses = ["juanmauricio.garzon@globant.com"]
vulnerability_assessment_email_addresses = ["juanmauricio.garzon@globant.com"]


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
vnet_resource_group = "rg-sql-single-database"
private_endpoint_name = "private-endpoint"
subnet_id = "/subscriptions/a265068d-a38b-40a9-8c88-fb7158ccda23/resourceGroups/rg-sql-support/providers/Microsoft.Network/virtualNetworks/vnet-endpoint/subnets/subnet-endpoint"
private_service_connection_name = "any_optional_name"
vnet_id = "/subscriptions/a265068d-a38b-40a9-8c88-fb7158ccda23/resourceGroups/rg-sql-support/providers/Microsoft.Network/virtualNetworks/vnet-endpoint"

//--- DNS configuration
private_dns_zone_name = "privatelink.database.windows.net"
private_dns_zone_vnet_link_name = "private_dsn_zone_vnet_link"
private_dns_zone_config_name = "private_dns_zone_config_name"
private_dns_zone_group_name = "private_dns_zone_group_name"