resource "azurerm_cosmosdb_account" "this" {
  name                = local.validated_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  offer_type          = var.offer_type
  kind                = "GlobalDocumentDB"

  dynamic "capabilities" {
    for_each = var.capabilities
    content {
      name = capabilities.value
    }
  }

  default_identity_type = var.default_identity_type

  consistency_policy {
    consistency_level = var.consistency_level
  }

  geo_location {
    location          = data.azurerm_resource_group.this.location
    failover_priority = 0
  }

  # Security and network configurations
  public_network_access_enabled = var.public_network_access_enabled

  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled
  local_authentication_disabled     = var.local_authentication_disabled
  minimal_tls_version               = var.minimal_tls_version

  # Backup configuration
  backup {
    type                = var.backup_type
    tier                = var.backup_tier
    interval_in_minutes = var.backup_interval_in_minutes
    retention_in_hours  = var.backup_retention_in_hours
    storage_redundancy  = var.backup_storage_redundancy
  }

  analytical_storage {
    schema_type = var.analytical_storage_schema_type
  }

  # Identity configuration
  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  # Customer Managed Key (CMK) configuration
  key_vault_key_id = var.key_vault_key_id

  tags = var.tags
}

# Diagnostic settings for CosmosDB
resource "azurerm_monitor_diagnostic_setting" "cosmosdb" {
  name                       = "diag-${local.validated_name}"
  target_resource_id         = azurerm_cosmosdb_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # CosmosDB logs
  enabled_log {
    category = "DataPlaneRequests"
  }

  enabled_log {
    category = "ControlPlaneRequests"
  }

  enabled_log {
    category = "QueryRuntimeStatistics"
  }

  enabled_log {
    category = "PartitionKeyStatistics"
  }

  enabled_log {
    category = "PartitionKeyRUConsumption"
  }

  enabled_log {
    category = "MongoRequests"
  }
  enabled_metric {
    category = "Requests"
  }
  enabled_metric {
    category = "SLI"
  }
}