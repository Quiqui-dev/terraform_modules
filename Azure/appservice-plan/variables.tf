variable "environment" {
  type        = string
  nullable    = false
  description = "Short name for this environment - dev, pre, prd"

  validation {
    condition     = can(regex("[a-z0-9][a-z0-9][a-z0-9]", var.environment))
    error_message = "Environment short name must be 3 lower caser characters or numbers"
  }
}

variable "region" {
  type        = string
  nullable    = false
  description = "The Azure region where the resource must be deployed"

}

variable "persistent_tags" {
  type        = map(string)
  nullable    = true
  description = "A map of tags to be applied to the resource"
}

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The resource group to deploy this resource"
}

variable "app_service_plan_os_type" {
  type        = string
  nullable    = false
  description = "The OS type for the app service plan"

  validation {
    condition     = can(regex("^(Linux|Windows|WindowsContainer)", var.app_service_plan_os_type))
    error_message = "Can only use one of the supported OS Types"
  }
}

variable "app_service_plan_sku_name" {
  type        = string
  nullable    = false
  description = "The sku type to make this app service plan"
}

variable "app_service_plan_name" {
  type        = string
  nullable    = false
  description = "The identifiable name of the ASP"
}

variable "asp_per_site_scaling_enabled" {
  type        = bool
  nullable    = false
  description = "Enables per site scaling on this ASP"
}

variable "asp_zone_balancing_enabled" {
  type        = bool
  nullable    = false
  description = "Enables zone balancing on this ASP"
}

variable "app_service_environment_id" {
  type        = string
  nullable    = true
  description = "If provided, specifies the ASE to build the ASP in. When blank, the ASP is not built in an ASE"
}
