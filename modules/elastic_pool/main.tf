//--- Azure SQL Elastic Pool resource definition
//-------------------------------------------------
resource "azurerm_mssql_elasticpool" "elastic" {

    name = var.elastic_pool_name
    resource_group_name = var.resource_group
    location = var.location
    server_name = var.server_name
    tags = var.tags
    max_size_gb = var.sku_tier != local.basic_service_tier_name ? var.max_size_gb : null
    license_type = var.license_type
 
    // Service tier settings
    sku {
        name = var.sku_name
        tier = var.sku_tier
        capacity = var.sku_capacity
        family = var.sku_family
    }

    // Elastic pool per database settings
    per_database_settings {
        min_capacity = var.db_settings_min_capacity
        max_capacity = var.db_settings_max_capacity
    }
   
    zone_redundant = (
        (var.sku_tier == local.premium_service_tier_name || 
         var.sku_tier == local.business_critical_service_tier_name) ? var.zone_redundant : null
    )
}