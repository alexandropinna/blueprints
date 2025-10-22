resource "azurerm_ai_foundry" "this" {
  name                = local.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  storage_account_id  = var.storage_account_id
  key_vault_id        = var.key_vault_id

  application_insights_id = var.application_insights_id
  container_registry_id   = var.container_registry_id

  description   = var.description
  friendly_name = var.friendly_name

  high_business_impact_enabled = var.high_business_impact_enabled

  dynamic "encryption" {
    for_each = var.encryption ? [1] : []
    content {
      key_id                    = var.encryption_key_id
      key_vault_id              = var.key_vault_id
      user_assigned_identity_id = var.encryption_user_assigned_identity_id
    }
  }

  managed_network {
    isolation_mode = var.managed_network_isolation_mode
  }

  public_network_access = var.public_network_access

  tags = merge(local.tags, var.tags)

  primary_user_assigned_identity = var.primary_user_assigned_identity
  
  identity {
    type         = var.identity_type
    identity_ids = length(var.user_assigned_identity_ids) > 0 ? var.user_assigned_identity_ids : null
  }
}