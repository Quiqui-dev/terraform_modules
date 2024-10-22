

variable "resource_id_for_diagnostic_settings" {
  type        = string
  nullable    = false
  description = "Resource ID of the resource enabling diagnostic settings"
}

variable "logs_to_enable" {
  type        = list(string)
  nullable    = true
  default     = [""]
  description = "List of logs to enable for the resource"
}

variable "metrics_to_enable" {
  type        = list(string)
  nullable    = true
  default     = [""]
  description = "List of metrics to be enabled for the resource"
}

variable "log_analytics_destination_type" {
  type        = string
  nullable    = true
  default     = "Dedicated"
  description = "Defines log analytics table location"

  validation {
    condition     = var.log_analytics_destination_type == null || can(regex("^(Dedicated|AzureDiagnostics|null)", var.log_analytics_destination_type))
    error_message = "must be Dedicated or AzureDiagnostics"
  }
}



variable "log_analytics_workspace_id" {
  type        = string
  nullable    = false
  description = "The id of the log analytics workspace to send the logs to"
}
