locals {
  # Extracting the last part of the resource group name (instance number)
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  region_short    = local.rg_parts[3]  # Fourth element: region short code
  instance_number = local.rg_parts[length(local.rg_parts) - 1]

  # Nomenclature: func-<cl>-<env>-<reg>-<comp>-<stamp>-<inst>
  name = "func-${local.client_code}-${local.environment}-${local.region_short}-${var.component}-${var.stamp}-${local.instance_number}"

  # Validated name (max 60 characters for function app)
  validated_name = length(local.name) > 60 ? substr(local.name, 0, 60) : local.name
}