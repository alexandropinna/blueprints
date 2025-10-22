# Service Bus Namespace outputs
output "namespace_id" {
  description = "The ID of the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.this.id
}

output "namespace_name" {
  description = "The name of the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.this.name
}

output "namespace_connection_string" {
  description = "The primary connection string for the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.this.default_primary_connection_string
  sensitive   = true
}

output "namespace_primary_key" {
  description = "The primary access key for the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.this.default_primary_key
  sensitive   = true
}

# Queues outputs
output "queue_ids" {
  description = "Map of queue names to their IDs"
  value = {
    for name, queue in azurerm_servicebus_queue.this : name => queue.id
  }
}

output "queue_names" {
  description = "List of created queue names"
  value       = [for queue in azurerm_servicebus_queue.this : queue.name]
}

# Topics outputs
output "topic_ids" {
  description = "Map of topic names to their IDs"
  value = {
    for name, topic in azurerm_servicebus_topic.this : name => topic.id
  }
}

output "topic_names" {
  description = "List of created topic names"
  value       = [for topic in azurerm_servicebus_topic.this : topic.name]
}

# Subscriptions outputs
output "subscription_ids" {
  description = "Map of subscription keys to their IDs"
  value = {
    for key, subscription in azurerm_servicebus_subscription.this : key => subscription.id
  }
}

# Authorization rules outputs
output "authorization_rule_ids" {
  description = "Map of authorization rule names to their IDs"
  value = {
    for name, rule in azurerm_servicebus_namespace_authorization_rule.this : name => rule.id
  }
}

output "diagnostics_authorization_rule_id" {
  description = "The ID of the diagnostics authorization rule"
  value       = azurerm_servicebus_namespace_authorization_rule.this["diagnostics"].id
}

output "primary_connection_string" {
  description = "The primary connection string for the diagnostics authorization rule"
  value       = azurerm_servicebus_namespace_authorization_rule.this["diagnostics"].primary_connection_string
  sensitive   = true
  
}