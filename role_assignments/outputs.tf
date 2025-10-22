output "ids" {
  description = "The IDs of the created role assignments"
  value       = { for k, v in azurerm_role_assignment.this : k => v.id }
}

output "names" {
  description = "The names of the created role assignments"
  value       = { for k, v in azurerm_role_assignment.this : k => v.name }
}