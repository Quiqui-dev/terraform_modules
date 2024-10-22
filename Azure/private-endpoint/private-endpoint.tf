
resource "azurerm_private_endpoint" "private-endpoint" {

  name                = join("-", [var.name_prefx, "pel", format("%03s", var.resource_instance)])
  location            = var.region
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.parent_resource_name}-private-service-connection-${format("%03s", var.resource_instance)}-psc-001"
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = false
    subresource_names              = var.private_endpoint_subresource_type
  }

  tags = var.persistent_tags

  lifecycle {
    ignore_changes = [
      private_dns_zone_group
    ]
  }
}
