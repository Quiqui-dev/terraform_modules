
# create the rg

resource "azurerm_resource_group" "service-rg" {

  name     = join("-", [var.platform_name, "${upper(substr(var.region, 0, 3))}${substr(var.region, 3 - length(var.region), -1)}", upper(var.environment), format("%.2f", var.environment_version), var.service_name, "rg"])
  location = var.region

  tags = var.persistent_tags

}

output "rg_name" {
  value = azurerm_resource_group.service-rg.name
}

output "rg_id" {
  value = azurerm_resource_group.service-rg.id
}
