resource "azurerm_role_assignment" "this" {
  for_each = local.all_assignments

  scope                = each.value.scope

  # Use either role_definition_id or role_definition_name
  role_definition_id   = try(each.value.role_definition_id, null)
  role_definition_name = try(each.value.role_definition_name, null)

  principal_id         = try(each.value.principal_id, var.principal_id)
  principal_type       = try(each.value.principal_type, var.principal_type)
  description          = try(each.value.description, var.description)
  skip_service_principal_aad_check = try(each.value.skip_sp_aad_check, var.skip_service_principal_aad_check)
}