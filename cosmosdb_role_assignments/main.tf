# Dynamic approach using for_each with locals
resource "azurerm_cosmosdb_sql_role_assignment" "assignments" {
  for_each = local.role_assignments

  name                = each.value.uuid
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  principal_id        = each.value.principal_id
  role_definition_id  = "${var.scope}/sqlRoleDefinitions/${each.value.role_id}"
  scope               = var.scope
}