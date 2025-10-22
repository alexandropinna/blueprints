resource "azurerm_storage_account" "this" {
  name                     = var.name == "" ? local.name : var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location == null ? data.azurerm_resource_group.this.location : var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  min_tls_version          = var.min_tls_version

  # Optional flags
  allow_nested_items_to_be_public  = var.allow_nested_items_to_be_public
  is_hns_enabled                   = var.is_hns_enabled
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled

  shared_access_key_enabled = var.shared_access_key_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication

  # Identity for customer managed key access - always required
  identity {
    type         = var.identity_type
    identity_ids = [var.user_assigned_identity_id]
  }

  network_rules {
    default_action             = var.network_rules_default_action
    bypass                     = var.network_rules_bypass
    ip_rules                   = var.network_rules_ip_rules
    virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids
  }
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  # Customer Managed Key encryption - always enabled
  customer_managed_key {
    key_vault_key_id          = var.key_vault_key_id
    user_assigned_identity_id = var.user_assigned_identity_id
  }

  tags = var.tags
}

# Diagnostic settings for Storage Account
resource "azurerm_monitor_diagnostic_setting" "storage_account" {
  name                       = "diag-${local.validated_name}"
  target_resource_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Storage Account metrics only (logs need to be configured per service like blob, table, etc.)
  enabled_metric {
    category = "Transaction"
  }

  enabled_metric {
    category = "Capacity"
  }
}
