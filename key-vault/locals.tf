locals {
  # Extracting the last part of the resource group name (instance number)
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  # region_short    = local.rg_parts[3]  # Fourth element: region short code
  region_short = var.region_short == null ? local.rg_parts[3] : var.region_short
  instance_number = local.rg_parts[length(local.rg_parts) - 1]

  # Nomenclature: kv<cl><env><reg><comp><stamp><inst> (without dashes)
  name = "kv${local.client_code}${local.environment}${local.region_short}${var.component}${var.stamp}${local.instance_number}"

  # Validated name (max 24 characters for key vault, lowercase alphanumeric only)
  validated_name = substr(
    lower(replace(local.name, "/[^a-z0-9]/", "")),
    0,
    24
  )
}