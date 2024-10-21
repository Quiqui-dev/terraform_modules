variable "environment" {
  type        = string
  nullable    = false
  description = "Short name for this environment - dev, pre, prd"

  validation {
    condition     = can(regex("[a-z0-9][a-z0-9][a-z0-9]", var.environment))
    error_message = "Environment short name must be 3 lower caser characters or numbers"
  }
}

variable "platform_name" {
  type        = string
  nullable    = false
  description = "Friendly name for this platform and instance"

  validation {
    condition     = length(var.platform_name) >= 10 && length(var.platform_name) <= 40
    error_message = "The platform name must be a minimum of 10 characters and a maximum of 40 characters"
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

variable "web_app_name_suffix" {
  type        = string
  nullable    = false
  description = "An identifiable suffix to append to the end of the web app name."
}

variable "app_service_plan_id" {
  type        = string
  nullable    = false
  description = "The id of the app service plan which will host the web app"
}

variable "custom_hosting_domain" {
  type        = string
  nullable    = true
  default     = ""
  description = "Custom hosting domain for the web app"
}

variable "app_settings" {
  type        = map(string)
  nullable    = true
  description = "a map of app_settings to apply to the web app"
}

variable "site_config" {
  type        = map(string)
  nullable    = false
  description = "a map of site_config to be applied to the web app"
}

