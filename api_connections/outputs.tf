output "api_connection_ids" {
  description = "Map of API connection IDs"
  value       = { for k, v in azapi_resource.this : k => v.id }
}

output "api_connection_names" {
  description = "Map of API connection names"
  value       = { for k, v in azapi_resource.this : k => v.name }
}

output "api_connections" {
  description = "Full API connection objects"
  value       = azapi_resource.this
}

output "api_connection_runtime_urls" {
  description = "Map of API connection runtime URLs (for Logic App references)"
  value = {
    for k, v in azapi_resource.this : k => try(
      jsondecode(v.output).properties.connectionRuntimeUrl,
      null
    )
  }
}
