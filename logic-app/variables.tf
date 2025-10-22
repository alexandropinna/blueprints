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
  description = "The Azure location where the Logic App will be created"
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
  default     = "logic"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

# Required variables
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "identity_type" {
  description = "The type of identity to use for the Logic App"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of user-assigned identity IDs for the Logic App"
  type        = list(string)
  default     = []
}

variable "parameters" {
  description = "A map of Key-Value pairs"
  type        = map(string)
  default     = {}
}

variable "cosmosdb_endpoint" {
  description = "CosmosDB endpoint URL for Logic App connections"
  type        = string
  default     = ""
}

variable "cosmosdb_name" {
  description = "CosmosDB account name for Logic App connections"
  type        = string
  default     = ""
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
