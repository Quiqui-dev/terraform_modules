

#generate a random name for the storage account

resource "random_string" "account-name" {
  length  = 20
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "storage-account" {

  name = "${random_string.account-name.result}${var.resource_instance}"

  resource_group_name              = var.resource_group_name
  location                         = var.region
  account_kind                     = var.storage_account_type
  account_tier                     = var.storage_account_tier
  account_replication_type         = var.replication_type
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  access_tier                      = var.access_tier
  https_traffic_only_enabled       = true
  shared_access_key_enabled        = true

  public_network_access_enabled   = true
  default_to_oauth_authentication = false

  blob_properties {

    change_feed_enabled           = true
    change_feed_retention_in_days = 30
    versioning_enabled            = true

    container_delete_retention_policy {
      days = 30
    }

    delete_retention_policy {
      days = 30
    }

    restore_policy {
      days = 29
    }
  }

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.allowed_subnet_ids
    ip_rules                   = var.allowed_CIDR_ranges
    bypass                     = ["Logging", "Metrics", "AzureServices"]
  }

  tags = var.persistent_tags
}

module "storage_account_private_endpoitn" {
  source = "git::https://github.com/Quiqui-dev/terraform_modules/tree/main/Azure/private-endpoint"

  count = var.private_endpoint_subnet_id == null ? 0 : 1

  resource_instance                   = var.resource_instance
  name_prefix                         = var.name_prefix
  parent_resource_name                = azurerm_storage_account.storage-account.name
  region                              = var.region
  resource_group_name                 = var.resource_group_name
  private_endpoint_subnet_id          = var.private_endpoint_subnet_id
  private_connection_subresource_type = [var.private_endpoint_subresource_type]
  private_link_dns_zone_for_records   = var.private_link_dns_zone_for_records

  persistent_tags = var.persistent_tags
}

output "storage_account_name" {
  value = azurerm_storage_account.storage-account.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage-account.id
}
