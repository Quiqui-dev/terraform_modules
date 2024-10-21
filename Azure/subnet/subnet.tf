

resource "azurerm_subnet" "subnet" {
  name = join("-", [var.platform_name, var.environment, "sub", var.subnet_number])

  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes

  private_link_service_network_policies_enabled = var.enable_private_link_policies
  default_outbound_access_enabled               = var.default_outbound_access_from_subnet
}


output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
