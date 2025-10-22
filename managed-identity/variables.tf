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
  description = "The Azure location where the Managed Identity will be created"
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
  default     = "id"
}

variable "stamp" {
  description = "Stamp identifier (3-5 chars)"
  type        = string
  default     = "s1"
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the User Assigned Managed Identity will be created."
  type        = string
}

variable "role_definition_names" {
  description = "A set of role definition names to assign to the User Assigned Managed Identity."
  type        = set(string)
  default     = [
    "Storage Blob Data Contributor", 
    "Key Vault Secrets User", 
    "Key Vault Crypto Officer", 
    "DocumentDB Account Contributor", 
    "Cosmos DB Account Reader Role", 
    "Cosmos DB Operator", 
    "Azure Service Bus Data Owner",
    "Key Vault Crypto Service Encryption User"
]

}

variable "tags" {
  description = "A map of tags to assign to the User Assigned Managed Identity."
  type        = map(string)
  default     = {}
}

# CosmosDB RBAC Variables
variable "cosmosdb_account_id" {
  description = "CosmosDB Account ID for RBAC role assignments"
  type        = string
  default     = null
}

variable "cosmosdb_account_name" {
  description = "CosmosDB Account name for RBAC role assignments"
  type        = string
  default     = null
}

variable "cosmosdb_resource_group_name" {
  description = "Resource group name where CosmosDB is located"
  type        = string
  default     = null
}

variable "key_vault_id" {
  description = "Key Vault ID for crypto service role assignment"
  type        = string
  default     = null
}

variable "enable_cosmosdb_rbac" {
  description = "Enable CosmosDB RBAC role assignments"
  type        = bool
  default     = true
}

variable "enable_key_vault_crypto" {
  description = "Enable Key Vault crypto role assignment"
  type        = bool
  default     = true
}