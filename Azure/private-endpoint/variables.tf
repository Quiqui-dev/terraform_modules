
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

variable "private_endpoint_subnet_id" {
  type        = string
  nullable    = true
  default     = null
  description = "if a subnet id is given then a private endpoint is created, ignored if none is provided"
}

variable "parent_resource_name" {
  type        = string
  nullable    = false
  description = "the instance name of the resource to attach the private endpoint to"
}

variable "private_connection_resource_id" {
  type        = string
  nullable    = false
  description = "The resource id of the resource to connect with the private endpoint"
}

variable "private_endpoint_subresource_type" {
  type        = list(string)
  nullable    = false
  description = "The subresources which the PE is able to connect to"
}

variable "name_prefx" {
  type        = string
  nullable    = false
  description = "An identifiable prefix to associate with the private endpoint"
}

variable "resource_instance" {
  type        = string
  nullable    = false
  description = "unique resource index - used to uniquely identify the parent instance and all child instances"

  validation {
    condition     = can(regex("[0-9][0-9][0-9]"))
    error_message = "The resource instance must be between 000 and 999"
  }
}


variable "private_link_dns_zone_for_records" {
  type        = list(any)
  nullable    = true
  description = "The private link DNS zone IDs for DNS record creation"
}

variable "persistent_tags" {
  type        = map(string)
  nullable    = true
  description = "A map of tags to be applied to the resource"
}
