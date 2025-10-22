locals {
  # Extracting parts from the resource group name
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  region_short = var.region_short == null ? local.rg_parts[3] : var.region_short  # Fourth element: region short code
  instance_number = local.rg_parts[length(local.rg_parts) - 1]  # Last element: instance number

  # Nomenclature: st<cl><env><reg><comp><stamp><inst> (without dashes)
  name = "st${local.client_code}${local.environment}${local.region_short}${var.component}${var.stamp}${local.instance_number}"

  # Validated name (max 24 characters for storage account)
  validated_name = length(local.name) > 24 ? substr(local.name, 0, 24) : local.name
}