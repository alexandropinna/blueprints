resource "azurerm_cognitive_account" "this" {
  name                = local.name
  location            = var.location == null ? data.azurerm_resource_group.this.location : var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind
  sku_name            = var.sku_name

  custom_subdomain_name      = var.custom_subdomain_name
  dynamic_throttling_enabled = var.dynamic_throttling_enabled

  fqdns = var.fqdns

  identity {
    type         = var.identity_type
    identity_ids = length(var.user_assigned_identity_ids) > 0 ? var.user_assigned_identity_ids : null
  }

  dynamic "network_acls" {
    for_each = var.enable_network_acls ? [1] : []
    content {
      default_action = var.network_acls_default_action
      ip_rules       = var.network_acls_ip_rules

      dynamic "virtual_network_rules" {
        for_each = var.network_acls_virtual_network_rules
        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = try(virtual_network_rules.value.ignore_missing_vnet_service_endpoint, false)
        }
      }
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.enable_customer_managed_key ? [1] : []
    content {
      key_vault_key_id   = var.key_vault_key_id
      identity_client_id = try(var.identity_client_id, null)
    }
  }

  lifecycle {
    ignore_changes = [customer_managed_key]
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "docint_storage_blob_contributor" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_cognitive_account.this.identity[0].principal_id
}