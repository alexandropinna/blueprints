# Data source for GitHub Actions IP ranges
data "http" "github_meta" {
  url = "https://api.github.com/meta"

  request_headers = {
    Accept = "application/vnd.github+json"
  }
}

locals {
  # Extracting the last part of the resource group name (instance number)
  rg_parts        = split("-", var.resource_group_name)
  client_code     = local.rg_parts[1]  # Second element: client code
  environment     = local.rg_parts[2]  # Third element: environment
  region_short    = local.rg_parts[3]  # Fourth element: region short code
  instance_number = local.rg_parts[length(local.rg_parts) - 1]

  # Nomenclature: app-<cl>-<env>-<reg>-<comp>-<stamp>-<inst>
  name = "app-${local.client_code}-${local.environment}-${local.region_short}-${var.component}-${var.stamp}-${local.instance_number}"

  # Validated name (max 60 characters for web app)
  validated_name = length(local.name) > 60 ? substr(local.name, 0, 60) : local.name

  # GitHub Actions IP ranges - manual core ranges to avoid 512 rule limit
  # These cover the main networks used by GitHub Actions and Azure runners
  github_ip_ranges = [
    "4.0.0.0/8",      # Covers 4.148.x.x, 4.149.x.x, 4.150.x.x, etc.
    "13.0.0.0/8",     # Covers 13.64.x.x, 13.65.x.x, 13.66.x.x, etc.
    "20.0.0.0/8",     # Azure principal network
    "52.0.0.0/8",     # Azure secondary network
    "140.82.112.0/20" # GitHub.com core infrastructure
  ]
}