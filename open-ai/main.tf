resource "azurerm_cognitive_account" "this" {
  name                = local.name
  location            = var.location == null ? data.azurerm_resource_group.this.location : var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind
  sku_name            = var.sku_name

  custom_subdomain_name      = var.custom_subdomain_name == null ? local.customer_subdomain_name : var.custom_subdomain_name
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

      bypass = var.network_acl_by_pass

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


resource "azurerm_cognitive_deployment" "this" {
  name                 = "deployment-${local.name}"
  cognitive_account_id = azurerm_cognitive_account.this.id
  rai_policy_name      = var.rai_policy_name

  sku {
    name = var.ais_sku_name
  }
  dynamic "model" {
    for_each = var.model != null ? [var.model] : [{}]
    content {
      format  = try(model.value.format, "OpenAI")
      name    = try(model.value.name, "gpt-5-mini")
      version = try(model.value.version, "2025-08-07")
    }
  }
  lifecycle {
    ignore_changes = [sku[0].capacity]
  }
}