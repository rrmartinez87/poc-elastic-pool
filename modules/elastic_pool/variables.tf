/*
  Input variable definitions for an Azure SQL Elastic Pool resource and its dependences
*/


//--- Elastic pool variables
//------------------------------
variable "elastic_pool_name" { 
    description = "The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created."
    type = string
}

variable "resource_group" { 
    description = "The name of the resource group in which to create the elastic pool. This must be the same as the resource group of the underlying SQL server."
    type = string
}

variable "location" { 
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
    type = string
}

variable "server_name" { 
    description = "The name of the SQL Server on which to create the elastic pool. Changing this forces a new resource to be created."
    type = string
}

variable "max_size_gb" { 
    description = "The max data size of the elastic pool in gigabytes."
    type = number
}

variable "license_type" { 
    description = "Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
    type = string
    default = "BasePrice"
}

variable "zone_redundant" { 
    description = "Whether or not this elastic pool is zone redundant. Tier needs to be Premium for DTU based or BusinessCritical for vCore based sku. Defaults to false"
    type = bool
    default = false
}

variable "tags" { 
    description = "A mapping of tags to assign to the resource."
    type = map
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
    default = 0
}

variable "db_settings_max_capacity" { 
    description = "The maximum capacity any one database can consume."
    type = number
    default = 2
}