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
  description = "The Azure location where the Service Plan will be created"
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
  default     = "asp"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "plan_type" {
  description = "Type of service plan (func, web, etc.)"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group where the service will be created."
  type        = string
}

variable "sku_name" {
  description = "The SKU tier for the service plan (e.g., Free, Basic, Standard, Premium)."
  type        = string
  default     = "EP1"
}

variable "os_type" {
  description = "The operating system type for the service plan (e.g., 'Linux', 'Windows')."
  type        = string
  default     = "Linux"
}


variable "tags" {
  description = "A map of tags to assign to the Azure Spring Apps service."
  type        = map(string)
  default     = {}
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

variable "name" {
  description = "allow engineer to replace naming convention, ideally this should not be set."
  default = ""
  type    = string

}