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
  description = "The Azure location where the Log Analytics Workspace will be created"
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
  default     = "log"
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

## Log Analytics Workspace
variable "sku" {
  description = "The SKU of the Log Analytics Workspace. Possible values are 'Free', 'PerNode', 'PerGB2018'."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The number of days to retain data in the Log Analytics Workspace."
  type        = number
  default     = 365
}

variable "daily_quota_gb" {
  description = "The daily data ingestion quota for the Log Analytics Workspace in GB. Set to -1 for unlimited."
  type        = number
  default     = -1
}

variable "internet_ingestion_enabled" {
  description = "Enable or disable internet ingestion for the Log Analytics Workspace."
  type        = bool
  default     = true
}

variable "law_internet_query_enabled" {
  description = "Enable or disable internet query for the Log Analytics Workspace."
  type        = bool
  default     = true
}

variable "allow_resource_only_permissions" {
  description = "Allow resource-only permissions for the Log Analytics Workspace."
  type        = bool
  default     = true
}

# Application Insights
variable "application_type" {
  description = "The type of application for Application Insights. Possible values are 'web', 'other'."
  type        = string
  default     = "web"
}

variable "appi_internet_query_enabled" {
  description = "Enable or disable internet query for Application Insights."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the Function App."
  type        = map(string)
  default     = {}
}

# Customer Managed Key Variables
variable "cmk_for_query_forced" {
  description = "Force the use of customer managed keys for query operations"
  type        = bool
  default     = false
}

variable "name" {
  description = "allow engineer to replace naming convention, ideally this should not be set."
  default = ""
  type    = string

}