# Global variables
variable "client_code" {
  description = "Client code for resource naming (2-4 chars)"
  type        = string
  default     = "brc"
}

variable "environment" {
  description = "Environment short name (3-4 chars, e.g., dev, uat, prd)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure location where the Service Bus will be created"
  type        = string
  default     = "eastus2"
}

variable "region_short" {
  description = "Short region code (e.g., eus2, weu)"
  type        = string
  default     = "eus2"
}

variable "component" {
  description = "Component identifier (3-6 chars)"
  type        = string
  default     = "bus"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Service Bus Namespace Variables
variable "sku" {
  description = "The SKU of the Service Bus Namespace. Options are 'Basic', 'Standard', or 'Premium'"
  type        = string
  default     = "Standard"
}

variable "capacity" {
  description = "The capacity of the Service Bus Namespace (only applicable for Premium SKU)"
  type        = number
  default     = null
}

variable "premium_messaging_partitions" {
  description = "The number of messaging partitions for Premium SKU (1, 2, or 4)"
  type        = number
  default     = 1
}

variable "minimum_tls_version" {
  description = "The minimum TLS version required for the Service Bus Namespace"
  type        = string
  default     = "1.2"
}

variable "zone_redundant" {
  description = "Whether the Service Bus Namespace should be zone redundant"
  type        = bool
  default     = false
}

# Identity
variable "identity_type" {
  description = "The type of identity to assign to the Service Bus"
  type        = string
  default     = "None"
  validation {
    condition     = contains(["None", "SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "identity_type must be one of: None, SystemAssigned, UserAssigned"
  }
}

variable "identity_ids" {
  description = "A list of User Managed Identity IDs to be assigned to the Service Bus"
  type        = list(string)
  default     = []
}

# Queues Configuration
variable "queues" {
  description = "List of queues to create"
  type = list(object({
    name                                    = string
    max_delivery_count                      = optional(number, 10)
    lock_duration                           = optional(string, "PT1M")
    default_message_ttl                     = optional(string, "P14D")
    dead_lettering_on_message_expiration    = optional(bool, false)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    max_message_size_in_kilobytes           = optional(number, 1024)
    max_size_in_megabytes                   = optional(number, 1024)
    requires_duplicate_detection            = optional(bool, false)
    requires_session                        = optional(bool, false)
  }))
  default = [
    {
      name = "messages"
    },
    {
      name = "notifications"
    }
  ]
}

# Topics Configuration
variable "topics" {
  description = "List of topics to create with their subscriptions"
  type = list(object({
    name                                    = string
    default_message_ttl                     = optional(string, "P14D")
    duplicate_detection_history_time_window = optional(string, "PT10M")
    max_message_size_in_kilobytes           = optional(number, 1024)
    max_size_in_megabytes                   = optional(number, 1024)
    requires_duplicate_detection            = optional(bool, false)
    support_ordering                        = optional(bool, false)
    subscriptions = optional(list(object({
      name                                      = string
      max_delivery_count                        = optional(number, 10)
      lock_duration                             = optional(string, "PT1M")
      default_message_ttl                       = optional(string, "P14D")
      dead_lettering_on_message_expiration      = optional(bool, false)
      dead_lettering_on_filter_evaluation_error = optional(bool, true)
      requires_session                          = optional(bool, false)
    })), [])
  }))
  default = [
    {
      name = "events"
      subscriptions = [
        {
          name = "main-subscriber"
        }
      ]
    }
  ]
}

# Authorization Rules
variable "authorization_rules" {
  description = "List of authorization rules for the namespace"
  type = list(object({
    name   = string
    listen = optional(bool, false)
    send   = optional(bool, false)
    manage = optional(bool, false)
  }))
  default = [
    {
      name   = "diagnostics"
      listen = true
      send   = true
      manage = false
    }
  ]
}


variable "tags" {
  description = "A map of tags to assign to the Service Bus"
  type        = map(string)
  default     = {}
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

# Customer Managed Key Variables
variable "customer_managed_key" {
  description = "Customer managed key configuration for Service Bus encryption"
  type = object({
    key_vault_key_id                  = string
    identity_id                       = string
    infrastructure_encryption_enabled = optional(bool, false)
  })
  default = null
}