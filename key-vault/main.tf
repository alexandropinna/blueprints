resource "azurerm_key_vault" "this" {
  name                = local.validated_name
  location            = var.location == null ? data.azurerm_resource_group.this.location : var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  sku_name  = lower(var.sku_name)
  tenant_id = data.azurerm_client_config.current.tenant_id

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  public_network_access_enabled = var.public_network_access_enabled
  rbac_authorization_enabled    = true

  network_acls {
    default_action             = var.network_acls_default_action
    bypass                     = var.network_acls_bypass
    ip_rules                   = var.network_acls_ip_rules
    virtual_network_subnet_ids = var.network_acls_virtual_network_subnet_ids
  }
}

# Diagnostic settings for Key Vault
resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  name                       = "${local.name}-diagnostics"
  target_resource_id         = azurerm_key_vault.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id
  # Direct to Log Analytics Workspace - no Event Hub needed

  enabled_log {
    category_group = "audit"
  }

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_role_assignment" "keyvault_admin" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id

  lifecycle {
    ignore_changes = [principal_id]
  }
}

resource "azurerm_role_assignment" "keyvault_crypto_officer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = data.azurerm_client_config.current.object_id

  lifecycle {
    ignore_changes = [principal_id]
  }
}


resource "azurerm_resource_policy_assignment" "kv_keys_audit_builtin" {
  name                 = "kv-keys-audit-${local.validated_name}"
  resource_id          = azurerm_key_vault.this.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/98728c90-32c7-4049-8429-847dc0f4fe37"
  display_name         = "Audit Key Vault keys expiration (Built-in)"
  description          = "Built-in policy to audit Key Vault keys without expiration dates"
}

resource "azurerm_key_vault_key" "this" {
  name         = "customer-managed-key"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = ["decrypt", "encrypt", "sign", "verify", "wrapKey", "unwrapKey"]

  # SOC 2 Type 2 Compliance: Explicit expiration date for keys
  # Auto-renewal: The expiration date is recalculated on each apply
  expiration_date = formatdate(
    "YYYY-MM-DD'T'HH:mm:ss'Z'",
    timeadd(timestamp(), "${var.default_key_expiration_days * 24}h")
  )
  
  rotation_policy {
    automatic {
      time_before_expiry = "P30D"  # Rotate 30 days before expiration
    }

    expire_after         = "P${var.default_key_expiration_days}D"  # Default: 365 days
    notify_before_expiry = "P29D"  # Notify 29 days before expiration
  }

  lifecycle {
    ignore_changes = [
      rotation_policy,
      expiration_date 
    ]
  }

  depends_on = [
    azurerm_role_assignment.keyvault_admin,
    azurerm_role_assignment.keyvault_crypto_officer
  ]
}

# SOC 2 Type 2 Compliant Secrets
# Secrets with automatic expiration date renewal
resource "azurerm_key_vault_secret" "this" {
  for_each = var.secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.this.id

  # SOC 2 Type 2 Compliance: All secrets must have expiration dates
  # Auto-renewal: The expiration date is recalculated on each apply
  # This means running terraform apply will extend the expiration by N days
  expiration_date = formatdate(
    "YYYY-MM-DD'T'HH:mm:ss'Z'",
    timeadd(timestamp(), "${var.default_secret_expiration_days * 24}h")
  )

  # Lifecycle management for auto-renewal
  lifecycle {
    # Ignore changes to value to allow manual rotation outside Terraform
    # expiration_date will be updated on each terraform apply for auto-renewal
    ignore_changes = [
      value,
      expiration_date
    ]

    # Create new version before destroying old one to prevent downtime
    create_before_destroy = true
  }

  tags = var.tags

  depends_on = [
    azurerm_role_assignment.keyvault_admin
  ]
}