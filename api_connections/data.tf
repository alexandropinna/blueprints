data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_managed_api" "apis" {
  for_each = var.api_connections

  name     = each.value.api_name
  location = data.azurerm_resource_group.this.location
}
