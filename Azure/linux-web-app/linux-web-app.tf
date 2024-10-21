
resource "azurerm_linux_web_app" "linux_web_app" {

  name                = "${substr(var.platform_name, 0, 4)}${substr(var.platform_name, -3, -1)}-${var.environment}-${substr(var.region, 0, 3)}-${var.web_app_name_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.region
  service_plan_id     = var.app_service_plan_id

  app_settings = merge(
    var.app_settings
  )

  site_config {}

  identity {
    type = "SystemAssigned"
  }

  tags = var.persistent_tags

}

resource "azurerm_app_service_custom_hostname_binding" "web_app_custom_domain" {
  count = var.custom_hosting_domain == "" ? 0 : 1

  hostname            = var.custom_hosting_domain
  app_service_name    = azurerm_linux_web_app.linux_web_app.name
  resource_group_name = var.platform_name
}

output "web_app_id" {
  value = azurerm_linux_web_app.linux_web_app.id
}

output "web_app_linux" {
  value = azurerm_linux_web_app.linux_web_app
}
