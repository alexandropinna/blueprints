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
  description = "The Azure location where the Web App will be created"
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
  default     = "web"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Linux Web App will be created."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the Service Plan that this Linux Web App will use."
  type        = string
}


variable "https_only" {
  description = "Should the Linux Web App only be accessible via HTTPS? Defaults to true."
  type        = bool
  default     = true
}

variable "client_affinity_enabled" {
  description = "Enable client affinity (ARR cookie) for the web app."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the Web App. Defaults to false."
  type        = bool
  default     = false
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "Enable FTP publish basic authentication for the Web App."
  type        = bool
  default     = false
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Enable Web Deploy publish basic authentication for the Web App."
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "The type of Managed Identity to enable. Possible values are 'SystemAssigned', 'UserAssigned', 'SystemAssigned, UserAssigned'."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of User Assigned Managed Identity IDs to assign to the Web App. Required if identity_type is 'UserAssigned' or 'SystemAssigned, UserAssigned'."
  type        = list(string)
  default     = []
}

# Site Configuration
variable "site_config" {
  description = "Site configuration for the Web App"
  type = object({
    ftps_state                     = optional(string, "FtpsOnly")
    minimum_tls_version           = optional(string, "1.3")
    always_on                     = optional(bool, true)
    http2_enabled                 = optional(bool, true)

    # Application Stack
    node_version                  = optional(string, "22-lts")

    # IP Restrictions
    enable_github_ip_restrictions = optional(bool, false)
    ip_restriction_default_action = optional(string, "Allow")

    # Custom IP restrictions (in addition to GitHub)
    custom_ip_restrictions = optional(list(object({
      ip_address = string
      action     = string
      priority   = number
      name       = string
    })), [])
  })
  default = {}
}

variable "client_certificate_enabled" {
  description = "Enable client certificate authentication for the web app"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "The client certificate mode for the web app. Possible values are 'Required', 'Optional', 'OptionalInteractiveUser'."
  type        = string
  default     = "Optional"

  validation {
    condition     = contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "Client certificate mode must be one of: Required, Optional, OptionalInteractiveUser."
  }
}

variable "auth_settings" {
  description = "Authentication settings for the Web App."
  type = object({
    enabled                       = optional(bool, false)
    default_provider              = optional(string, null)
    unauthenticated_client_action = optional(string, null)
    token_store_enabled           = optional(bool, false)
    issuer                        = optional(string, null)
    active_directory = optional(object({
      client_id                  = string
      client_secret_setting_name = optional(string, null)
      allowed_audiences          = optional(list(string), [])
    }), null)
  })
  default = {}
}

variable "app_settings" {
  description = "A map of application settings to assign to the Linux Web App."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the Linux Web App."
  type        = map(string)
  default     = {}
}

# Application Insights Variables
variable "application_insights_connection_string" {
  description = "Connection string for Application Insights"
  type        = string
  default     = null
  sensitive   = true
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

# Customer Managed Key Variables
variable "key_vault_reference_identity_id" {
  description = "The User Assigned Identity ID for accessing Key Vault references. Required for CMK."
  type        = string
  default     = null
}

# Legacy variables (moved to site_config object - these will be deprecated)
