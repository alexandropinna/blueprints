output "id" {
  description = "The ID of the Cognitive Services (Document Intelligence) account."
  value       = azurerm_cognitive_account.this.id
}

output "endpoint" {
  description = "The endpoint URL of the Cognitive Services (Document Intelligence) account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "primary_key" {
  description = "The primary access key of the Cognitive Services account."
  value       = azurerm_cognitive_account.this.primary_access_key
  sensitive   = true
}
