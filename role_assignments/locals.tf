  locals {
    # Map for individual assignment if scopes and role_definition_name are provided
    individual_assignments = var.scopes != [] && var.role_definition_name != "" ? {
      for i, scope in var.scopes : "role_${i}" => {
        scope = scope
        role_definition_name = var.role_definition_name
        principal_id = var.principal_id
        description = var.description
        skip_sp_aad_check = var.skip_service_principal_aad_check
      }
    } : {}

    # Combined map of all assignments
    all_assignments = merge(var.role_assignments, local.individual_assignments)
  }