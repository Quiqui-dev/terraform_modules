

variable "platform_name" {
  type        = string
  nullable    = false
  description = "Friendly name for this platform and instance"

  validation {
    condition     = length(var.platform_name) >= 10 && length(var.platform_name) <= 40
    error_message = "The platform name must be a minimum of 10 characters and a maximum of 40 characters"
  }
}

variable "environment" {
  type        = string
  nullable    = false
  description = "Short name for this environment - dev, pre, prd"

  validation {
    condition     = can(regex("[a-z0-9][a-z0-9][a-z0-9]", var.environment))
    error_message = "Environment short name must be 3 lower caser characters or numbers"
  }
}

variable "resource_group_name" {
  type        = string
  nullable    = false
  description = "The name of the resource group to create this network in"
}

variable "region" {
  type        = string
  nullable    = false
  description = "The Azure region where the resource must be deployed"

}

variable "address_space" {
  type     = list(string)
  nullable = false

  description = "list of address spaces for this vnet"
}

variable "subnets" {
  type        = map(string)
  nullable    = true
  default     = null
  description = "Any subnets to create with this vnet"
}

variable "dns_servers" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "list of dns servers for this vnet"
}

variable "persistent_tags" {
  type        = map(string)
  nullable    = true
  description = "A map of tags to be applied to the resource"
}
