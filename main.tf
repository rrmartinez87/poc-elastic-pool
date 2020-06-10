// Azure provider configuration
terraform {
  required_version = ">= 0.12"
  backend "azurerm" {}
}
provider "azurerm" {
    version = "~>2.0"
    features {}
	subscription_id = "a7b78be8-6f3c-4faf-a43d-285ac7e92a05"
	tenant_id       = "c160a942-c869-429f-8a96-f8c8296d57db"
 }
// Resource required to generate random guids
resource "random_uuid" "poc" { }

// Azure resource group definition
resource "azurerm_resource_group" "rg" {

  // Arguments required by Terraform API
  name = join(local.separator, [var.resource_group_name, random_uuid.poc.result])
  location = var.location

  // Optional Terraform resource manager arguments but required by architecture
  tags = var.tags
}

// Azure SQL database server resource definition
resource "azurerm_mssql_server" "dbserver" {

  // Arguments required by Terraform API
  name = join(local.separator, [var.server_name, random_uuid.poc.result])
  resource_group_name = (azurerm_resource_group.rg != null ? azurerm_resource_group.rg.name : var.resource_group_name)
  location = var.location
  version = var.server_version
  administrator_login = var.administrator_login
  administrator_login_password = var.administrator_login_password
  
  // Optional Terraform resource manager arguments but required by architecture
  connection_policy = local.connection_type
  public_network_access_enabled = local.public_network_access
  tags = var.tags
}

// Azure SQL elastic pool resource definition
resource "azurerm_mssql_elasticpool" "elastic" {
  
  // Arguments required by Terraform API
  name = join(local.separator, [var.elastic_pool_name, random_uuid.poc.result])
  resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  server_name = azurerm_mssql_server.dbserver.name

  sku {
    name = var.sku_name
    tier = var.sku_tier
    family = var.sku_family // optional based on tier
    capacity = var.sku_capacity
  }

  per_database_settings {
    min_capacity = var.db_settings_min_capacity
    max_capacity = var.db_settings_max_capacity
  }

  // Optional Terraform resource manager arguments but required by architecture
  max_size_gb = var.max_size_gb
  tags = var.tags
}

// Create sample database in the elastic pool
resource "azurerm_mssql_database" "singledb" {

  // Arguments required by Terraform API
  name = var.single_database_name
  server_id = azurerm_mssql_server.dbserver.id
  sample_name = local.sample_database

  // Optional Terraform resource manager arguments but required by architecture
  elastic_pool_id = azurerm_mssql_elasticpool.elastic.id
  //max_size_gb = var.single_max_size_gb
  //sku_name = var.service_tier
  tags = var.tags
}

// Create virtual network to set up a private endpoint later
resource "azurerm_virtual_network" "vnet" {
  
  // Arguments required by Terraform API
  name                = join(local.separator, [var.vnet_name, random_uuid.poc.result])
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  // Optional Terraform resource manager arguments but required by architecture
  tags = var.tags
}

// Create associated subnet
resource "azurerm_subnet" "subnet" {
  
  // Arguments required by Terraform API
  name                 = join(local.separator, [var.subnet_name, random_uuid.poc.result])
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
  
  // Optional Terraform resource manager arguments but required by architecture
  enforce_private_link_endpoint_network_policies = true
  service_endpoints = ["Microsoft.Sql"]
}

// Create a private endpoint to connect to the server using private access
resource "azurerm_private_endpoint" "endpoint" {
  
  // Arguments required by Terraform API
  name                = join(local.separator, [var.private_endpoint_name, random_uuid.poc.result])
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = var.service_connection_name
    private_connection_resource_id = azurerm_mssql_server.dbserver.id
    is_manual_connection           = var.requires_manual_approval
    subresource_names = ["sqlServer"]
  }

  // Optional Terraform resource manager arguments but required by architecture
  tags = var.tags
}

// Create a Private DNS Zone for SQL Database domain.
resource "azurerm_private_dns_zone" "dnszone" {
  
  // Arguments required by Terraform API
  name = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.rg.name

  // Optional Terraform resource manager arguments but required by architecture
  tags = var.tags
}

// Create an association link with the Virtual Network.
resource "azurerm_private_dns_zone_virtual_network_link" "dnslink" {
  
  // Arguments required by Terraform API
  name = var.private_dns_zone_vnet_link
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone.name
  virtual_network_id = azurerm_virtual_network.vnet.id

  // Optional Terraform resource manager arguments but required by architecture
  tags = var.tags
}

// Create a DNS Zone Group to associate the private endpoint with the Private DNS Zone.
resource "null_resource" "set_private_dns_zone_config" { 
  provisioner local-exec {
    command = "az network private-endpoint dns-zone-group create --endpoint-name ${azurerm_private_endpoint.endpoint.name} --name MyZoneGroup --private-dns-zone ${azurerm_private_dns_zone.dnszone.id} --resource-group ${azurerm_resource_group.rg.name} --zone-name 'privatelink.database.windows.net'"
  }

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.dnslink
  ]
}

// Set database server TLS version after server creation (unsupported Azure provider argument)
// This setting can only be configured once a private enpoint is in place
resource "null_resource" "set_server_tls_version" { 
  provisioner local-exec {
    command = "az sql server update --name ${azurerm_mssql_server.dbserver.name} --resource-group ${azurerm_resource_group.rg.name} --minimal-tls-version ${local.tls_version}"
  }

  depends_on = [
    azurerm_private_endpoint.endpoint
  ]
}
