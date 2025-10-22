output "function_app_id" {
  description = "The ID of the Function App."
  value       = azurerm_linux_function_app.this.id
}

output "function_app_name" {
  description = "The name of the Function App."
  value       = azurerm_linux_function_app.this.name
}

output "function_app_default_hostname" {
  description = "The default host name of the Function App."
  value       = azurerm_linux_function_app.this.default_hostname
}