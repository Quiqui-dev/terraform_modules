

module "storage_account" {
  source = "git::https://github.com/Quiqui-dev/terraform_modules/tree/main/Azure/private-storage-account"

  count = var.create_storage_account == true ? 1 : 0

  resource_group_name               = var.resource_group_name
  region                            = var.region
  name_prefx                        = var.name_prefix
  resource_instance                 = "001"
  private_endpoint_subnet_id        = var.storage_account_private_endpoint_subnet
  private_endpoint_subresource_type = "blob"
  containers_to_create              = ["azure-webjobs-hosts", "azure-webjobs-secrets"]
  allowed_CIDR_ranges               = var.allowed_CIDR_ranges
  allowed_subnet_ids                = var.storage_account_allowed_subnet_ids
  persistent_tags                   = var.persistent_tags

  replication_type     = "ZRS"
  storage_account_tier = "Premium"
  storage_account_type = "StorageV2"

  private_link_dns_zone_for_records = var.private_link_dns_zone_for_records

}

data "azurerm_storage_account" "function_storage_account" {
  depends_on          = [module.storage_account]
  name                = var.storage_account_name_for_func_app != null ? var.storage_account_name_for_func_app : module.storage_account[0].storage_account_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_function_app" "function_app" {

  depends_on = [module.storage_account]

  name                = "${var.platform_name}-${upper(var.environment)}-${upper(substr(var.region, 0, 3))}-${var.name_identifier}-fa1"
  resource_group_name = var.resource_group_name
  location            = var.region

  storage_account_name       = data.azurerm_storage_account.function_storage_account.name
  storage_account_access_key = data.azurerm_storage_account.function_storage_account.primary_access_key

  service_plan_id = var.app_service_plan_id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                = "true"
    ftps_state               = "FtpsOnly"
    application_insights_key = null
    vnet_route_all_enabled   = true
  }

  tags = var.persistent_tags

  lifecycle {
    ignore_changes = [
      app_settings,
      site_config
    ]
  }
}



output "func_app_id" {
  value = azurerm_linux_function_app.function_app.id
}

output "func_app_name" {
  value = azurerm_linux_function_app.function_app.name
}

