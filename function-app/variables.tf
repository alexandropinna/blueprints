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
  description = "The Azure location where the Function App will be created"
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
  default     = "func"
}

variable "stamp" {
  description = "Stamp identifier for function app type (server, client, api, etc.)"
  type        = string
  default     = "srv"
}

variable "service_plan_id" {
  description = "The ID of the Service Plan to be used by the Function App."
  type        = string

}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Function App will be created."
  type        = string
}

# Function App

variable "storage_account_name" {
  description = "The name of the Storage Account required by the Function App."
  type        = string
}

variable "storage_uses_managed_identity" {
  description = "Specifies whether the Storage Account uses Managed Identity for authentication."
  type        = string
  default     = true
}

variable "https_only" {
  description = "Specifies whether the Function App should only accept HTTPS traffic."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access for the Function App."
  type        = bool
  default     = true
}

variable "virtual_network_subnet_ids" {
  description = "The ID of the Virtual Network Subnet to which the Function App should be connected. Set to null if not using VNet integration."
  type        = string
  default     = null
}

variable "identity_type" {
  description = "The type of Managed Identity to assign to the Function App. Possible values are 'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned', or 'None'."
  type        = string
  default     = "UserAssigned"
}

variable "identity_ids" {
  description = "List of User Assigned Identity IDs to assign to the Function App if identity_type includes 'UserAssigned'."
  type        = list(string)
  default     = []
}

variable "managed_identity_client_id" {
  description = "Client ID of the User Assigned Managed Identity for Storage Account authentication"
  type        = string
  default     = null
}

variable "service_bus_connection_string" {
    description = "Service Bus connection string"
    type = string
    default = null
  }

# Site Configuration
variable "site_config" {
  description = "Site configuration for the Function App"
  type = object({
    always_on              = optional(bool, false)
    http2_enabled          = optional(bool, true)
    ftps_state            = optional(string, "FtpsOnly")
    minimum_tls_version   = optional(string, "1.3")
    use_32_bit_worker     = optional(bool, false)
    vnet_route_all_enabled = optional(bool, true)

    # IP Restrictions
    ip_restrictions = optional(list(object({
      ip_address = string
      action     = string
    })), [])

    scm_ip_restrictions = optional(list(object({
      ip_address = string
      action     = string
    })), [])

    # Application Stack
    python_version = optional(string, "3.13")

    # Application Insights
    application_insights_connection_string = optional(string, null)

    # CORS Configuration
    cors_allowed_origins = optional(list(string), ["https://portal.azure.com"])
    cors_support_credentials = optional(bool, false)
  })
  default = {}
}

# Legacy variables for backward compatibility (deprecated)
variable "client_certificate_mode" {
  description = "The client certificate mode for the Function App. Possible values are 'Required', 'Optional', and 'OptionalInteractiveUser'."
  type        = string
  default     = "Optional"
}

variable "client_certificate_enabled" {
  description = "Enable or disable client certificate authentication for the Function App."
  type        = bool
  default     = false
}


# Legacy variables (moved to site_config object - these will be deprecated)

variable "app_settings" {
  description = "A map of App Settings for the Function App."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the Function App."
  type        = map(string)
  default     = {}
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

# Customer Managed Key Variables
variable "storage_key_vault_secret_id" {
  description = "The Key Vault secret ID containing the storage account connection string for CMK. Set to null to use default storage."
  type        = string
  default     = null
}

variable "name" {
  description = "allow engineer to replace naming convention, ideally this should not be set."
  default = ""
  type    = string

}