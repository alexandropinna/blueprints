output "cosmosdb_assignments" {
  description = "The IDs of the CosmosDB Role Assignments"
  value       = { for k, v in azurerm_cosmosdb_sql_role_assignment.assignments : k => v.id }
}

output "cosmosdb_roles" {
  description = "Map of CosmosDB assignments to their role definition IDs"
  value       = { for k, v in azurerm_cosmosdb_sql_role_assignment.assignments : k => v.role_definition_id }
}