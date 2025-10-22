output "id" {
  description = "The ID of the Logic App Workflow"
  value       = azurerm_logic_app_workflow.this.id
}

output "name" {
  description = "The name of the Logic App Workflow"
  value       = azurerm_logic_app_workflow.this.name
}

output "location" {
  description = "The location of the Logic App Workflow"
  value       = azurerm_logic_app_workflow.this.location
}

output "resource_group_name" {
  description = "The resource group name of the Logic App Workflow"
  value       = azurerm_logic_app_workflow.this.resource_group_name
}

output "access_endpoint" {
  description = "The Access Endpoint for the Logic App Workflow"
  value       = azurerm_logic_app_workflow.this.access_endpoint
}

output "connector_endpoint_ip_addresses" {
  description = "The list of access endpoint IP addresses of connector"
  value       = azurerm_logic_app_workflow.this.connector_endpoint_ip_addresses
}

output "connector_outbound_ip_addresses" {
  description = "The list of outgoing IP addresses of connector"
  value       = azurerm_logic_app_workflow.this.connector_outbound_ip_addresses
}

output "workflow_endpoint_ip_addresses" {
  description = "The list of access endpoint IP addresses of workflow"
  value       = azurerm_logic_app_workflow.this.workflow_endpoint_ip_addresses
}

output "workflow_outbound_ip_addresses" {
  description = "The list of outgoing IP addresses of workflow"
  value       = azurerm_logic_app_workflow.this.workflow_outbound_ip_addresses
}
