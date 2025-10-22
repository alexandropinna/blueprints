locals {
  # Extracting the last part of the resource group name (instance number)
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  region_short    = local.rg_parts[3]  # Fourth element: region short code
  instance_number = local.rg_parts[length(local.rg_parts) - 1]

  # Nomenclature: sb<cl><env><reg><comp><stamp><inst> (without dashes)
  name = "sb${local.client_code}${local.environment}${local.region_short}${var.component}${var.stamp}${local.instance_number}"

  # Validated name (max 50 characters for Service Bus namespace)
  validated_name = length(local.name) > 50 ? substr(local.name, 0, 50) : local.name
}