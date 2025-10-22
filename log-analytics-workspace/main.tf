# This resource block creates a Log Analytics Workspace in Azure.
resource "azurerm_log_analytics_workspace" "this" {

  name                = var.name == "" ? local.name : var.name
  location            = var.location == null ? data.azurerm_resource_group.this.location : var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  daily_quota_gb                  = var.daily_quota_gb
  internet_ingestion_enabled      = var.internet_ingestion_enabled
  internet_query_enabled          = var.law_internet_query_enabled
  allow_resource_only_permissions = var.allow_resource_only_permissions
  cmk_for_query_forced            = var.cmk_for_query_forced

  tags = var.tags
}

# Create an Application Insights resource in Azure
resource "azurerm_application_insights" "this" {

  name                = "appi-${azurerm_log_analytics_workspace.this.name}"
  location            = azurerm_log_analytics_workspace.this.location
  resource_group_name = var.resource_group_name
  workspace_id        = resource.azurerm_log_analytics_workspace.this.id

  application_type       = var.application_type
  retention_in_days      = var.retention_in_days
  internet_query_enabled = var.appi_internet_query_enabled

  tags = var.tags
}

# Diagnostic settings for Application Insights
resource "azurerm_monitor_diagnostic_setting" "application_insights" {
  name                       = "diag-appi-${local.validated_name}"
  target_resource_id         = azurerm_application_insights.this.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  # Application Insights logs
  enabled_log {
    category = "AppAvailabilityResults"
  }

  enabled_log {
    category = "AppBrowserTimings"
  }

  enabled_log {
    category = "AppEvents"
  }

  enabled_log {
    category = "AppMetrics"
  }

  enabled_log {
    category = "AppDependencies"
  }

  enabled_log {
    category = "AppExceptions"
  }

  enabled_log {
    category = "AppPageViews"
  }

  enabled_log {
    category = "AppPerformanceCounters"
  }

  enabled_log {
    category = "AppRequests"
  }

  enabled_log {
    category = "AppSystemEvents"
  }

  enabled_log {
    category = "AppTraces"
  }

  # Application Insights metrics
  enabled_metric {
    category = "AllMetrics"
  }
}