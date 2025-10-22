# Global variables
variable "location" {
  description = "The Azure location where the API Connections will be created"
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
  default     = "app"
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

variable "api_connections" {
  description = <<-EOT
    Map of API connections to create. Key is the connection identifier.
    Each connection should have:
      - api_name: The name of the managed API (e.g., office365, azureblob, documentdb)
      - display_name: Display name for the connection
      - use_managed_identity: (Optional) Use Managed Identity authentication (default: false)
      - parameter_values: (Optional) Map of parameter values for custom authentication

    Example:
    {
      "office365" = {
        api_name           = "office365"
        display_name       = "demo@brisc.email"
        use_managed_identity = false  # OAuth - requires manual authorization in Portal
      }
      "azureblob" = {
        api_name           = "azureblob"
        display_name       = "Blob Storage Connection"
        use_managed_identity = true  # Automatic with Managed Identity
      }
      "documentdb" = {
        api_name           = "documentdb"
        display_name       = "CosmosDB Connection"
        use_managed_identity = true  # Automatic with Managed Identity
      }
    }

    Note: OAuth-based connections (like Office 365) require manual authorization in Azure Portal
    after deployment, even when created via Terraform.
  EOT
  type = map(object({
    api_name             = string
    display_name         = string
    use_managed_identity = optional(bool, false)
    parameter_values     = optional(map(string), {})
  }))
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
