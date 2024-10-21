

resource "azurerm_service_plan" "appservice_plan" {

  name                       = join("-", [var.app_service_plan_name, "asp"])
  location                   = var.region
  resource_group_name        = var.resource_group_name
  app_service_environment_id = var.app_service_environment_id
  os_type                    = var.app_service_plan_os_type
  sku_name                   = var.app_service_plan_sku_name
  per_site_scaling_enabled   = var.asp_per_site_scaling_enabled
  zone_balancing_enabled     = var.asp_zone_balancing_enabled

  tags = var.persistent_tags
}

output "asp_id" {
  value = azurerm_service_plan.appservice_plan.id
}
