# Service Bus Namespace
resource "azurerm_servicebus_namespace" "this" {
  name                = "sbns-${local.validated_name}"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  premium_messaging_partitions  = var.premium_messaging_partitions
  tags                          = var.tags

  minimum_tls_version = var.minimum_tls_version

  dynamic "identity" {
    for_each = var.identity_type != "None" ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [1] : []
    content {
      key_vault_key_id                  = var.customer_managed_key.key_vault_key_id
      identity_id                       = var.customer_managed_key.identity_id
      infrastructure_encryption_enabled = var.customer_managed_key.infrastructure_encryption_enabled
    }
  }
}

# Customer Managed Key is now configured directly in the azurerm_servicebus_namespace resource above

# Service Bus Queue
resource "azurerm_servicebus_queue" "this" {
  for_each = { for queue in var.queues : queue.name => queue }

  name         = each.value.name
  namespace_id = azurerm_servicebus_namespace.this.id

  max_delivery_count                      = each.value.max_delivery_count
  lock_duration                           = each.value.lock_duration
  default_message_ttl                     = each.value.default_message_ttl
  dead_lettering_on_message_expiration    = each.value.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  max_size_in_megabytes                   = each.value.max_size_in_megabytes
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  requires_session                        = each.value.requires_session
}

# Service Bus Topic
resource "azurerm_servicebus_topic" "this" {
  for_each = { for topic in var.topics : topic.name => topic }

  name         = each.value.name
  namespace_id = azurerm_servicebus_namespace.this.id

  default_message_ttl                     = each.value.default_message_ttl
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  max_size_in_megabytes                   = each.value.max_size_in_megabytes
  requires_duplicate_detection            = each.value.requires_duplicate_detection
  support_ordering                        = each.value.support_ordering
}

# Service Bus Topic Subscription
resource "azurerm_servicebus_subscription" "this" {
  for_each = {
    for sub in flatten([
      for topic in var.topics : [
        for subscription in topic.subscriptions : {
          key          = "${topic.name}-${subscription.name}"
          topic_name   = topic.name
          subscription = subscription
        }
      ]
    ]) : sub.key => sub
  }

  name               = each.value.subscription.name
  topic_id           = azurerm_servicebus_topic.this[each.value.topic_name].id
  max_delivery_count = each.value.subscription.max_delivery_count

  lock_duration                             = each.value.subscription.lock_duration
  default_message_ttl                       = each.value.subscription.default_message_ttl
  dead_lettering_on_message_expiration      = each.value.subscription.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error = each.value.subscription.dead_lettering_on_filter_evaluation_error
  requires_session                          = each.value.subscription.requires_session
}

# Authorization rules for namespace
resource "azurerm_servicebus_namespace_authorization_rule" "this" {
  for_each = { for rule in var.authorization_rules : rule.name => rule }

  name         = each.value.name
  namespace_id = azurerm_servicebus_namespace.this.id

  listen = each.value.listen
  send   = each.value.send
  manage = each.value.manage
}

# Diagnostic settings for Service Bus
resource "azurerm_monitor_diagnostic_setting" "service_bus" {
  name                       = "diag-${local.validated_name}"
  target_resource_id         = azurerm_servicebus_namespace.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Service Bus logs
  enabled_log {
    category = "OperationalLogs"
  }

  enabled_log {
    category = "VNetAndIPFilteringLogs"
  }

  enabled_log {
    category = "RuntimeAuditLogs"
  }

  # Service Bus metrics
  enabled_metric {
    category = "AllMetrics"
  }
}

