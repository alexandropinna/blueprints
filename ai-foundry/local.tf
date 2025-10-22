locals {
  tags = {
    "Managed By" = "Opentofu"
  }
  # Extracting the last part of the resource group name (instance number)
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  region_short    = local.rg_parts[3]  # Fourth element: region short code
  rg_number       = split("-", var.resource_group_name)[length(split("-", var.resource_group_name)) - 1]

  name = "aif-${local.client_code}-${local.environment}-${local.region_short}-${var.stamp}-${local.rg_number}"
}