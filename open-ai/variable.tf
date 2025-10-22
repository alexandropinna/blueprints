variable "client" {
  description = "Customer Name."
  type        = string
  default     = "briscai"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,30}$", var.client))
    error_message = "Client name must be up to 30 characters long, contain only letters, numbers, and hyphens."
  }
}

variable "region_short" {
  description = "Short region code (e.g., eus2, weu)"
  type        = string
  default     = null
}

variable "location" {
  description = "The Azure region where the Cognitive Service Account will be created."
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment tag (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Cognitive Service Account will exist."
  type        = string
}

variable "sku_name" {
  description = "Specifies the SKU Name for this Cognitive Service Account. Possible values: F0, F1, S0, S, S1, S2, S3, S4, S5, S6, P0, P1, P2, E0, DC0"
  type        = string

  validation {
    condition = contains([
      "F0", "F1",
      "S0", "S", "S1", "S2", "S3", "S4", "S5", "S6",
      "P0", "P1", "P2",
      "E0", "DC0"
    ], var.sku_name)
    error_message = "Valid values for sku_name: F0, F1, S0, S, S1–S6, P0–P2, E0, DC0."
  }
  default = "S0"
}

variable "storage_account_id" {
  description = "(Required) Full resource ID of a Microsoft.Storage resource."
  type        = string
}

variable "identity_client_id" {
  description = "(Optional) The client ID of the managed identity associated with the storage resource."
  type        = string
  default     = null
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of Managed Service Identity. Possible values: SystemAssigned, UserAssigned or (SystemAssigned, UserAssigned)."
  default     = "SystemAssigned"

  validation {
    condition = contains([
      "SystemAssigned",
      "UserAssigned",
      "SystemAssigned, UserAssigned"
    ], var.identity_type)
    error_message = "Valid values for identity_type are: SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  }
}

variable "user_assigned_identity_ids" {
  type        = list(string)
  description = "List of User Assigned Identity IDs (required if identity_type includes UserAssigned)."
  default     = []
}



variable "enable_network_acls" {
  description = "Enabled network ACLs."
  type        = bool
  default     = false
}

variable "network_acls_default_action" {
  description = "Values are Allow or Deny."
  type        = string
  default     = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_acls_default_action)
    error_message = "network_acls_default_action must be 'Allow' or 'Deny'."
  }
}

variable "network_acls_ip_rules" {
  description = "(Optional) IPs/CIDRs Allowed."
  type        = list(string)
  default     = []
}

variable "network_acls_virtual_network_rules" {
  description = ""
  type = list(object({
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))
  default = []
}

variable "custom_subdomain_name" {
  description = "(Optional) Custom subdomain name for the Cognitive Account."
  type        = string
  default     = null
}

variable "dynamic_throttling_enabled" {
  description = "(Optional) Whether dynamic throttling is enabled for the Cognitive Account."
  type        = bool
  default     = false
}

variable "fqdns" {
  description = "(Optional) Custom FQDN for the Cognitive Account."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "(Optional) Tags to apply to the resource."
  type        = map(string)
  default     = {}
}

variable "kind" {
  default     = "OpenAI"
  description = "cognitive account kind"
}

variable "network_acl_by_pass" {
  default     = "AzureServices"
  description = "Possible values are AzureServices or None"
  validation {
    condition     = contains(["AzureServices", "None"], var.network_acl_by_pass)
    error_message = "network_acl_by_pass must be 'AzureServices' or 'None'."
  }
}

variable "key_vault_key_id" {
  description = "Customer encryption ke ID for Cognitive Account"

}

variable "key_vault_id" {
  description = "The Key Vault ID to be used by the DI."
  type        = string
}

variable "enable_customer_managed_key" {
  description = "If true, creates the customer_managed_key block."
  type        = bool
  default     = false
}

variable "ais_sku_name" {
  description = "The SKU name for the cognitive deployment."
  type        = string
  default     = "Standard"

  validation {
    condition = contains([
      "Standard", "GlobalStandard"
    ], var.ais_sku_name)
    error_message = "Valid values for ais_sku_name: Standard, GlobalStandard."
  }
}

# Model Configuration
variable "model" {
  description = "Model configuration for the OpenAI cognitive deployment"
  type = object({
    format  = optional(string, "OpenAI")
    name    = optional(string, "gpt-5-mini")
    version = optional(string, "2025-08-07")
  })
  default = {}
}

variable "rai_policy_name" {
  description = "The name of the Responsible AI (RAI) policy for the deployment. Default is Microsoft.DefaultV2 for content filtering and compliance."
  type        = string
  default     = "Microsoft.DefaultV2"
}