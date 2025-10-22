variable "client" {
  description = "Customer Name."
  type        = string
  default     = "briscai"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,30}$", var.client))
    error_message = "Client name must be up to 30 characters long, contain only letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment tag (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure region where the AI Foundry Hub will be created."
  type        = string
  default     = "eastus2"
}

variable "region_short" {
  description = "Short region code (e.g., eus2, weu)"
  type        = string
  default     = "eus2"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the AI Foundry Hub will exist."
  type        = string
}

variable "key_vault_id" {
  description = "The Key Vault ID to be used by the AI Foundry Hub."
  type        = string
}

variable "storage_account_id" {
  description = "The Storage Account ID to be used by the AI Foundry Hub."
  type        = string
}

variable "application_insights_id" {
  type        = string
  description = "Resource ID of the Application Insights component used by AI Foundry (optional)."
  default     = null
}

variable "container_registry_id" {
  type        = string
  description = "Resource ID of the Azure Container Registry used by AI Foundry (optional)."
  default     = null
}

variable "encryption" {
  type        = bool
  description = "If true, enables the encryption block as well as high_business_impact_enabled"
  default     = false
}

variable "encryption_key_id" {
  type        = string
  description = "Key Vault URI of the customer-managed key."
  default     = null
}

variable "encryption_user_assigned_identity_id" {
  type        = string
  description = "User-assigned identity ID that has access to the key (optional)."
  default     = null
}

variable "high_business_impact_enabled" {
  type        = bool
  description = "Enables HBI (High Business Impact)."
  default     = false
}

variable "managed_network_isolation_mode" {
  type        = string
  description = "Isolation mode of the AI Foundry Hub. Allowed values: Disabled, AllowOnlyApprovedOutbound, AllowInternetOutbound."
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "AllowOnlyApprovedOutbound", "AllowInternetOutbound"], var.managed_network_isolation_mode)
    error_message = "Valid values are: Disabled, AllowOnlyApprovedOutbound, AllowInternetOutbound."
  }
}
variable "public_network_access" {
  type        = string
  default     = "Enabled"
  description = "(Optional) Whether public network access for this AI Service Hub should be enabled. Possible values include Enabled and Disabled. Defaults to Enabled."

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "Valid values for public_network_access are: Enabled or Disabled."
  }
}

variable "primary_user_assigned_identity" {
  type        = string
  description = "User Assigned Identity ID que representará la identidad del Hub cuando encryption=true."
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

variable "description" {
  type        = string
  description = "Description for the AI Foundry Hub (optional)."
  default     = null
}

variable "friendly_name" {
  type        = string
  description = "Friendly display name for the AI Foundry Hub (optional)."
  default     = null
}

variable "tags" {
  description = "Tags for organizing the AI Foundry Hub."
  type        = map(string)
  default     = {}
}
