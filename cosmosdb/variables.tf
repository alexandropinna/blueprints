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
  description = "The Azure location where the CosmosDB will be created"
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
  default     = "cosmos"
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

# Optional variables
variable "offer_type" {
  description = "Specifies the Offer Type to use for this MongoDB Account"
  type        = string
  default     = "Standard"
}

variable "consistency_level" {
  description = "The Consistency Level to use for this MongoDB Account"
  type        = string
  default     = "Session"
}

// ...existing code...

variable "capabilities" {
  description = "List of capabilities to enable for this Cosmos DB account"
  type        = list(string)
  default     = ["EnableServerless"]

  validation {
    condition = alltrue([
      for capability in var.capabilities : contains([
        "AllowSelfServeUpgradeToMongo36",
        "DeleteAllItemsByPartitionKey",
        "DisableRateLimitingResponses",
        "EnableAggregationPipeline",
        "EnableCassandra",
        "EnableGremlin",
        "EnableMongo",
        "EnableMongo16MBDocumentSupport",
        "EnableMongoRetryableWrites",
        "EnableMongoRoleBasedAccessControl",
        "EnableNoSQLVectorSearch",
        "EnableNoSQLFullTextSearch",
        "EnablePartialUniqueIndex",
        "EnableServerless",
        "EnableTable",
        "EnableTtlOnCustomPath",
        "EnableUniqueCompoundNestedDocs",
        "EnableFreeTier",
        "MongoDBv3.4",
        "mongoEnableDocLevelTTL"
      ], capability)
    ])
    error_message = "Invalid capability specified. Please check the documentation for valid capabilities."
  }
}

variable "database_name" {
  description = "The name of the MongoDB database"
  type        = string
  default     = "default-db"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "total_throughput_limit" {
  description = "The total throughput limit imposed on this Cosmos DB account (RU/s)"
  type        = number
  default     = 4000
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this CosmosDB account"
  type        = bool
  default     = true
}

variable "enable_automatic_failover" {
  description = "Enable automatic failover for this Cosmos DB account"
  type        = bool
  default     = true
}

variable "enable_multiple_write_locations" {
  description = "Enable multiple write locations for this Cosmos DB account"
  type        = bool
  default     = false
}

variable "is_virtual_network_filter_enabled" {
  description = "Enables virtual network filtering for this Cosmos DB account"
  type        = bool
  default     = false
}

variable "disable_key_based_metadata_write_access" {
  description = "Disable write operations on metadata resources (databases, containers, throughput)"
  type        = bool
  default     = false
}

variable "enable_analytical_storage" {
  description = "Enable Analytical Storage option for this Cosmos DB account"
  type        = bool
  default     = false
}

variable "analytical_storage_schema_type" {
  description = "The schema type of the Analytical Storage for this Cosmos DB account"
  type        = string
  default     = "WellDefined"
}

variable "network_acl_bypass" {
  description = "If azure services can bypass ACLs"
  type        = string
  default     = "None"
}

variable "local_authentication_disabled" {
  description = "Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication"
  type        = bool
  default     = true
}

variable "minimal_tls_version" {
  description = "Specifies the minimal TLS version for the CosmosDB account"
  type        = string
  default     = "Tls12"
}

variable "backup_type" {
  description = "The type of backup"
  type        = string
  default     = "Periodic"
}

variable "backup_tier" {
  description = "The backup tier"
  type        = string
  default     = null
}

variable "backup_interval_in_minutes" {
  description = "The interval in minutes between two backups"
  type        = number
  default     = 240
}

variable "backup_retention_in_hours" {
  description = "The time in hours that each backup is retained"
  type        = number
  default     = 8
}

variable "backup_storage_redundancy" {
  description = "The storage redundancy which is used to indicate type of backup residency"
  type        = string
  default     = "Geo"
}

variable "identity_type" {
  description = "The type of identity used for the Cosmos DB account"
  type        = string
  default     = "UserAssigned"
}

variable "identity_ids" {
  description = "List of user assigned identity IDs to be assigned to the CosmosDB account"
  type        = list(string)
}

variable "default_identity_type" {
  description = "The default identity type for CosmosDB Key Vault operations"
  type        = string
  default     = null
}

# Diagnostic Settings Variables
variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for diagnostic settings"
  type        = string
}

# Customer Managed Key Variables
variable "key_vault_key_id" {
  description = "The Key Vault Key ID for customer managed encryption. Set to null to disable CMK."
  type        = string
  default     = null
}