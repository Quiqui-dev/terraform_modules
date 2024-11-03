# Create any subnets required


module "subnet" {
  source = "github.com/Quiqui-dev/terraform_modules/Azure/subnet"

  for_each = var.subnets

  resource_group_name = var.resource_group_name
  vnet_name           = azurerm_virtual_network.vnet.name
  address_prefixes    = each.value
  subnet_number       = each.key
  environment         = var.environment
  platform_name       = var.platform_name

  default_outbound_access_from_subnet = true

  enable_private_link_policies = false
  region                       = var.region
  persistent_tags              = null
}
