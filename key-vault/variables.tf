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
  description = "The Azure location where the Key Vault will be created"
  type        = string
  default     = null
}

variable "region_short" {
  description = "Short region code (e.g., eus2, weu)"
  type        = string
  default     = null
}

variable "component" {
  description = "Component identifier (3-6 chars)"
  type        = string
  default     = "kv"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Function App will be created."
  type        = string
}

# Key Vault 
variable "sku_name" {
  description = "The SKU of the Key Vault. Options are 'standard' or 'premium'."
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "The number of days to retain deleted vaults before permanent deletion."
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "network_acls_default_action" {
  description = "The default action for network ACLs. Options are 'Allow' or 'Deny'."
  type        = string
  default     = "Allow"
}

variable "network_acls_bypass" {
  description = "The services that are allowed to bypass the network ACLs. Options include 'AzureServices', 'None'."
  type        = string
  default     = "AzureServices"
}

variable "network_acls_ip_rules" {
  description = "A list of IP addresses that are allowed to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "network_acls_virtual_network_subnet_ids" {
  description = "A list of virtual network subnet IDs that are allowed to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "enabled_for_deployment" {
  description = "Whether the Key Vault is enabled for deployment."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Whether the Key Vault is enabled for disk encryption."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Whether the Key Vault is enabled for template deployment."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Whether to enable RBAC authorization for the Key Vault."
  type        = bool
  default     = true
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account for diagnostic settings."
  type        = string
}


variable "tags" {
  description = "A map of tags to assign to the Key Vault."
  type        = map(string)
  default     = {}
}

# =============================================================================
# EXPIRATION POLICY VARIABLES
# =============================================================================

variable "enforce_secret_expiration" {
  description = "Whether to enforce expiration dates on all secrets and keys"
  type        = bool
  default     = true
}

variable "default_secret_expiration_days" {
  description = "Default expiration period for secrets in days"
  type        = number
  default     = 90

  validation {
    condition     = var.default_secret_expiration_days > 0 && var.default_secret_expiration_days <= 730
    error_message = "Expiration days must be between 1 and 730 (2 years)."
  }
}

variable "default_key_expiration_days" {
  description = "Default expiration period for keys in days"
  type        = number
  default     = 365

  validation {
    condition     = var.default_key_expiration_days > 0 && var.default_key_expiration_days <= 730
    error_message = "Key expiration days must be between 1 and 730 (2 years)."
  }
}

variable "secrets" {
  description = <<-EOT
    Map of dynamic secrets to store in Key Vault with expiration dates.
    These are typically outputs from other modules (Function Apps, Storage, etc.)
    Example: {
      "soc2-compliance-test" = "placeholder-for-compliance-audit"
    }
  EOT
  type        = map(string)
  default     = {}
}