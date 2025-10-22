output "id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.this.id
}

output "name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.this.name
}

output "insights_id" {
  value       = azurerm_application_insights.this.id
  description = "ID of the Application Insights"
}

output "insights_name" {
  value       = azurerm_application_insights.this.name
  description = "Name of the Application Insights"
}

output "insights_connection_string" {
  value       = azurerm_application_insights.this.connection_string
  description = "Connection string of the Application Insights"
  sensitive   = true
}

output "insights_instrumentation_key" {
  value       = azurerm_application_insights.this.instrumentation_key
  description = "Instrumentation key of the Application Insights"
  sensitive   = true
}
