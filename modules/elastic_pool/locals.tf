/*
  Default values that must be provided according to architecture and can't be setteable from outside the module,
  or values that can be reused along the module.
*/

locals {

    // Some service tier names
    basic_service_tier_name = "Basic"
    premium_service_tier_name = "Premium"
    business_critical_service_tier_name = "BusinessCritical"
}