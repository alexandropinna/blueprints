output "id" {
  description = "The ID of the MongoDB Account"
  value       = azurerm_cosmosdb_account.this.id
}

output "name" {
  description = "The name of the MongoDB Account"
  value       = azurerm_cosmosdb_account.this.name
}

output "endpoint" {
  description = "The endpoint used to connect to the MongoDB account"
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "primary_key" {
  description = "The Primary key for the MongoDB Account"
  value       = azurerm_cosmosdb_account.this.primary_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "Primary connection string for MongoDB"
  value       = azurerm_cosmosdb_account.this.primary_sql_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "Secondary connection string for MongoDB"
  value       = azurerm_cosmosdb_account.this.secondary_sql_connection_string
  sensitive   = true
}

output "principal_id" {
  description = "The principal ID of the CosmosDB account's managed identity"
  value       = try(azurerm_cosmosdb_account.this.identity[0].principal_id, null)
}
