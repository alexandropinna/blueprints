output "id" {
  value = azurerm_key_vault.this.id
}

output "name" {
  value = azurerm_key_vault.this.name
}

output "key_vault_key_id" {
  description = "The versionless ID of the Key Vault key used for CMK (null if not created)."
  value       = azurerm_key_vault_key.this.versionless_id
}

output "key_vault_key_version_id" {
  description = "Full Key Vault key ID including version"
  value       = azurerm_key_vault_key.this.id
}


output "key_vault_key_name" {
  description = "The name of the Key Vault key (null if not created)."
  value       = azurerm_key_vault_key.this.name
}

# =============================================================================
# EXPIRATION POLICY OUTPUTS
# =============================================================================

output "default_secret_expiration_days" {
  description = "Default expiration period for secrets in days"
  value       = var.default_secret_expiration_days
}

output "default_key_expiration_days" {
  description = "Default expiration period for keys in days"
  value       = var.default_key_expiration_days
}

output "enforce_secret_expiration" {
  description = "Whether expiration enforcement is enabled"
  value       = var.enforce_secret_expiration
}

output "policy_assignment_id" {
  description = "ID of the active policy assignment (built-in audit policy)"
  value       = azurerm_resource_policy_assignment.kv_keys_audit_builtin.id
}
