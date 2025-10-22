output "id" {
  value = azurerm_ai_foundry.this.id
}

output "discovery_url" {
  value = azurerm_ai_foundry.this.discovery_url
}

output "workspace_id" {
  value = azurerm_ai_foundry.this.workspace_id
}

output "principal_id" {
  value = azurerm_ai_foundry.this.identity[0].principal_id
}