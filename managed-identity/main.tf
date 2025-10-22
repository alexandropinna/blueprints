resource "azurerm_user_assigned_identity" "this" {
  name                = local.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_role_assignment" "this" {
  for_each = var.role_definition_names

  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
  role_definition_name = each.value
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

# CosmosDB SQL role definition (solo si hay CosmosDB configurado)
resource "azurerm_cosmosdb_sql_role_definition" "data_contributor" {
  count = var.enable_cosmosdb_rbac ? 1 : 0
  
  resource_group_name = var.cosmosdb_resource_group_name
  account_name        = var.cosmosdb_account_name
  name                = "Managed Identity Data Contributor"
  assignable_scopes   = [var.cosmosdb_account_id]

  permissions {
    data_actions = [
      "Microsoft.DocumentDB/databaseAccounts/readMetadata",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/*",
      "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*"
    ]
  }
}

# Role assignment para CosmosDB
resource "azurerm_cosmosdb_sql_role_assignment" "this" {
  count = var.enable_cosmosdb_rbac ? 1 : 0

  resource_group_name = var.cosmosdb_resource_group_name
  account_name        = var.cosmosdb_account_name
  role_definition_id  = azurerm_cosmosdb_sql_role_definition.data_contributor[0].id
  principal_id        = azurerm_user_assigned_identity.this.principal_id
  scope              = var.cosmosdb_account_id
}