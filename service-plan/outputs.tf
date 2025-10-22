output "id" {
  description = "The ID of the Azure Spring Apps service."
  value       = azurerm_service_plan.this.id
}

output "name" {
  description = "The name of the Azure Spring Apps service."
  value       = azurerm_service_plan.this.name
}