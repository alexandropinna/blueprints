output "location" {
  description = "Resource location"
  value       = azurerm_resource_group.this.location
}
output "id" {
  description = "Resource id"
  value       = azurerm_resource_group.this.id
}
output "name" {
  description = "Resource name"
  value       = azurerm_resource_group.this.name
}
output "tags" {
  description = "Resource tags"
  value       = azurerm_resource_group.this.tags
}