locals {
  # Extracting the last part of the resource group name (instance number)
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  region_short = var.region_short == null ? local.rg_parts[3] : var.region_short  # Fourth element: region short code
  instance_number = local.rg_parts[length(local.rg_parts) - 1]

  # Nomenclature: oai-<cl>-<env>-<reg>-<inst>
  name = "oai-${local.client_code}-${local.environment}-${local.region_short}-${local.instance_number}"

  # Nomenclature: oai-<cl>-<env>-<reg>-<inst>
  customer_subdomain_name = "oai-${local.client_code}-${local.environment}-${local.region_short}-${local.instance_number}"
}