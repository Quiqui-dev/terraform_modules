

resource "azurerm_monitor_diagnostic_setting" "diag_settings" {

  name = "log_to_central_Log_Analytics_Workspace"

  target_resource_id             = var.resource_id_for_diagnostic_settings
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "enabled_log" {
    for_each = var.logs_to_enable != null ? var.logs_to_enable : []

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.metrics_to_enable != null ? var.metrics_to_enable : []

    content {
      category = metric.value
    }
  }
}
