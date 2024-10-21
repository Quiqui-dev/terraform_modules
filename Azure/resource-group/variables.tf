variable "platform_name" {
  type        = string
  nullable    = false
  description = "Friendly name for this platform and instance"

  validation {
    condition     = length(var.platform_name) >= 10 && length(var.platform_name) <= 40
    error_message = "The platform name must be a minimum of 10 characters and a maximum of 40 characters"
  }
}

variable "service_name" {
  type = string
  nullable = false
  description = "Friendly name for this service and instance"

  validation {
    condition = length(var.service_name) >= 8 && length(var.service_name) <= 40
    error_message = "The service name must be a minimum of 10 characters and a maximum of 40 characters"
  }
}

variable "environment" {
    type = string
    nullable = false
    description = "Short name for this environment - dev, pre, prd"

    validation {
      condition = can(regex("[a-z0-9][a-z0-9][a-z0-9]", var.environment))
      error_message = "Environment short name must be 3 lower caser characters or numbers"
    }
}

variable "region" {
    type = string
    nullable = false
    description = "The Azure region where the resource must be deployed"

}

variable "environment_version" {
  type = number
  nullable = false

  description = "user defined, hopefully from tfvars, version of the environment - i.e. 0.01, 1.00, 2.16a"
}

variable "persistent_tags" {
    type = map(string)
    nullable = true
    description = "A map of tags to be applied to the resource"
}