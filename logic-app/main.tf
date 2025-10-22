resource "azurerm_logic_app_workflow" "this" {
  name                = local.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = var.resource_group_name

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  parameters = var.parameters
  lifecycle {
    ignore_changes = [parameters, workflow_parameters]
  }

  tags = var.tags
}

# Diagnostic settings for Logic App
resource "azurerm_monitor_diagnostic_setting" "logic_app" {
  name                       = "diag-${local.name}"
  target_resource_id         = azurerm_logic_app_workflow.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Logic App logs
  enabled_log {
    category = "WorkflowRuntime"
  }

  # Logic App metrics
  enabled_metric {
    category = "AllMetrics"
  }
}