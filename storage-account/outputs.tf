output "id" {
  value = azurerm_storage_account.this.id
}

output "name" {
  value = azurerm_storage_account.this.name
}

output "connection_string" {
  value       = azurerm_storage_account.this.primary_connection_string
  description = "Primary connection string (use with caution)."
  sensitive   = true
}

output "access_key" {
  value       = azurerm_storage_account.this.primary_access_key
  description = "Primary access key (use with caution)."
  sensitive   = true
}
