# Local values for role assignments
locals {
  # Crear lista plana con índices (keys estáticas)
  combinations = flatten([
    for pi, principal_id in var.principal_ids : [
      for ri, role_id in var.role_definition_names : {
        key = "principal_${pi}_role_${ri}"  # Key estática (conocida en plan)
        principal_id = principal_id         # Value (puede ser unknown)
        role_id = role_id
        principal_index = pi
        role_index = ri
      }
    ]
  ])

  # Convertir a map con keys estáticas
  role_assignments = {
    for combo in local.combinations :
    combo.key => {
      principal_id = combo.principal_id
      role_id = combo.role_id
      uuid = uuidv5("oid", "p${combo.principal_index}-r${combo.role_index}")
    }
  }
}
