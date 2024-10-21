

resource "azurerm_virtual_network" "vnet" {
  name = join("-", [var.platform_name, "${upper(substr(var.region, 0, 3))}${substr(var.region, 3 - length(var.region), -1)}", upper(var.environment), "vnet"])

  location            = var.region
  resource_group_name = var.resource_group_name

  address_space = var.address_space
  dns_servers   = var.dns_servers
}


output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
