variable "role_definition_names" {
  description = "A list of role definition names to assign to the principal."
  type        = list(string)
}
variable "scope" {
  description = "The scope where the role will be assigned"
  type        = string
}

variable "principal_ids" {
  description = "List of principal IDs to assign roles to"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Resource group name (required for CosmosDB assignments)"
  type        = string
  default     = null
}

variable "cosmosdb_account_name" {
  description = "CosmosDB account name (required for CosmosDB assignments)"
  type        = string
  default     = null
}