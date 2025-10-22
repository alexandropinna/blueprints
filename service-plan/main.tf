# Resource block to create an Azure Service Plan
resource "azurerm_service_plan" "this" {

  name     = var.name == "" ? local.name : var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name
  os_type  = var.os_type

  tags = var.tags
}

# Diagnostic settings for Service Plan
resource "azurerm_monitor_diagnostic_setting" "service_plan" {
  name                       = "diag-${local.validated_name}"
  target_resource_id         = azurerm_service_plan.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Service Plan metrics only (no log categories supported)
  enabled_metric {
    category = "AllMetrics"
  }
}