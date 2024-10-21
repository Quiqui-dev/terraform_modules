

resource "azurerm_linux_function_app" "function_app" {
  name                = ""
  resource_group_name = var.resource_group_name
  location            = var.region

  storage_account_name       = var.storage_account_name_for_func_app # TODO: storage account name if exists
  storage_account_access_key = null                                  # set this if required during refactor

  service_plan_id = var.app_service_plan_id

  site_config {

  }
}

# TODO: create a storage account resource if the create storage account flag is set


output "func_app_id" {
  value = azurerm_linux_function_app.function_app.id
}

output "func_app_name" {
  value = azurerm_linux_function_app.function_app.name
}

