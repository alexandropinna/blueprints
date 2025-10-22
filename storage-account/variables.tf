variable "client_code" {
  description = "Client code (2-4 chars)"
  type        = string
  default     = "brc"
}

variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
  default     = "dev"
}

variable "region_short" {
  description = "Region short code (e.g., eus2 for eastus2)"
  type        = string
  default     = null
}

variable "component" {
  description = "Component name (3-6 chars)"
  type        = string
  default     = "data"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where the storage account will be created."
  type        = string
  default     = null
}

variable "account_tier" {
  description = "Performance tier (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type (LRS, ZRS, GRS, RAGRS)."
  type        = string
  default     = "LRS"
}

variable "min_tls_version" {
  description = "Minimum supported TLS version."
  type        = string
  default     = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  description = "Allow nested items to be public."
  type        = bool
  default     = false

}

variable "is_hns_enabled" {
  description = "Enable Hierarchical Namespace (ADLS Gen2)."
  type        = bool
  default     = true
}

variable "cross_tenant_replication_enabled" {
  description = "Allow cross-tenant replication."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Enable shared access key for the storage account."
  type        = bool
  default     = false
}

variable "default_to_oauth_authentication" {
  description = "Force OAuth authentication for all requests."
  type        = bool
  default     = true
}

variable "identity_type" {
  description = "Type of identity for the storage account (e.g., UserAssigned)."
  type        = string
  default     = "UserAssigned"
}

variable "network_rules_default_action" {
  description = "Default action for network rules (Allow or Deny)."
  type        = string
  default     = "Allow"
}

variable "network_rules_bypass" {
  description = "Services that can bypass network rules (e.g., AzureServices, None)."
  type        = set(string)
  default     = ["AzureServices", "Logging", "Metrics"]
}

variable "network_rules_ip_rules" {
  description = "List of IP addresses allowed to access the storage account."
  type        = list(string)
  default     = []
}

variable "network_rules_virtual_network_subnet_ids" {
  description = "List of virtual network subnet IDs allowed to access the storage account."
  type        = list(string)
  default     = []
}

variable "infrastructure_encryption_enabled" {
  description = "Enable infrastructure encryption."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to assign to the storage account."
  type        = map(string)
  default     = {}
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

# Customer Managed Key Variables
variable "key_vault_key_id" {
  description = "The Key Vault Key ID for customer managed encryption. Required for all Storage Accounts."
  type        = string
}

variable "user_assigned_identity_id" {
  description = "The User Assigned Identity ID for accessing Key Vault keys. Required when using CMK."
  type        = string
}

variable "name" {
  description = "allow engineer to replace naming convention, ideally this should not be set."
  default = ""
  type    = string

}
