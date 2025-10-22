output "id" {
  description = "The ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "name" {
  description = "The Name of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.name
}

output "client_id" {
  description = "The Client ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "principal_id" {
  description = "The Principal ID of the User Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.principal_id
}