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

variable "storage_account_type" {
  type        = string
  nullable    = false
  description = "The type of storage account to create"

  validation {
    condition     = can(regex("^(BlockBlobStorage|StorageV2)"), var.storage_account_type)
    error_message = "Type must be BlockBlobStorage or StorageV2"
  }
}

variable "storage_account_tier" {
  type        = string
  nullable    = false
  description = "The tier of account to create"

  validation {
    condition     = can(regex("^(Premium|Standard)"), var.storage_account_tier)
    error_message = "Storage account tier must be Premium or Standard - is it?"
  }
}

variable "replication_type" {
  type        = string
  nullable    = false
  description = "The replication type for the data in the account"

  validation {
    condition     = can(regex("^(LRS|GRS|RAGRS|ZRS|GZRS|RAGZRS)", var.replication_type))
    error_message = "Must be one of LRS, GRS, RAGRS, ZRS, GZRS, or RAGZRS"
  }
}

variable "access_tier" {
  type        = string
  nullable    = false
  description = "The access tier of the account - Archive, Cold, or Hot"
  default     = "Hot"

  validation {
    condition     = can(regex("^(Hot|Cold|Archive)", var.access_tier))
    error_message = "Access tier must be one of Hot, Cold, or Archive"
  }
}

variable "name_prefx" {
  type        = string
  nullable    = false
  description = "An identifiable prefix to associate with the private endpoint"
}

variable "allowed_subnet_ids" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "A list of subnet ids that can connect to the storage account, bypassing the firewall"
}

variable "private_endpoint_subnet_id" {
  type        = string
  nullable    = true
  default     = null
  description = "If provided a private endpoint is created in the subnet and attached to the storage account. Private endpoint is not create if not provided"
}

variable "private_endpoint_subresource_type" {
  type        = string
  nullable    = true
  default     = null
  description = "Specifies the subresource type to assign to the private endpoint (only if a private endpoint is created)"

  validation {
    condition     = can(regex("^(blob|queue|table|file)", var.private_endpoint_subresource_type)) || var.private_endpoint_subresource_type == null
    error_message = "Check that the subresource type is null, blob, queue, table, or file - is it?"
  }
}

variable "containers_to_create" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "A list of containers to create in this storage account"
}

variable "private_link_dns_zone_for_records" {
  type        = list(any)
  nullable    = true
  description = "private link DNS zone ids for DNS record creation"
}

variable "allowed_CIDR_ranges" {
  type        = list(string)
  nullable    = true
  default     = null
  description = "CIDR ranges / IP ranges which are allowed to bypass the firewall"
}

variable "persistent_tags" {
  type        = map(string)
  nullable    = true
  description = "A map of tags to be applied to the resource"
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
