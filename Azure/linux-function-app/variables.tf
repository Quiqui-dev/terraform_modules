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

variable "name_identifier" {
  type        = string
  nullable    = false
  description = "An identifiable name for the resource"
}

variable "app_service_plan_id" {
  type        = string
  nullable    = false
  description = "The id of the app service plan which will host the web app"
}

variable "storage_account_name_for_func_app" {
  type        = string
  nullable    = true
  description = "The name of the storage account to link to this Azure Function App"
}

variable "storage_account_private_endpoint_subnet" {
  type        = string
  nullable    = true
  description = "The subnet which will host the private endpoint of the storage account"
}

variable "name_prefix" {
  type        = string
  nullable    = true
  description = "optional name prefix for the function app"
}

variable "storage_account_allowed_subnet_ids" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "A list of subnet ids that can access through the storage account firewall"
}

variable "create_storage_account" {
  type        = bool
  nullable    = false
  default     = false
  description = "If false then the storage account name must be supplied. If true then a storage account will be created"
}

variable "allowed_CIDR_ranges" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "CIDR Ranges which are permitted to access the storage account"
}


variable "private_link_dns_zone_for_records" {
  type        = list(any)
  nullable    = true
  description = "private link DNS zone ids for DNS record creation - should ideally come from a global module which can be referenced elsewhere"
}
