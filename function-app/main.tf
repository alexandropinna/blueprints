resource "azurerm_linux_function_app" "this" {
  name                = var.name == "" ? local.validated_name : var.name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.this.location

  service_plan_id               = var.service_plan_id
  storage_account_name          = var.storage_account_name
  storage_uses_managed_identity = var.storage_uses_managed_identity
  storage_key_vault_secret_id   = var.storage_key_vault_secret_id

  https_only = var.https_only
  client_certificate_mode = var.client_certificate_mode
  client_certificate_enabled = var.client_certificate_enabled
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_subnet_id = var.virtual_network_subnet_ids

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  site_config {
    always_on              = try(var.site_config.always_on, false)
    http2_enabled          = try(var.site_config.http2_enabled, true)
    ftps_state            = try(var.site_config.ftps_state, "FtpsOnly")
    minimum_tls_version   = try(var.site_config.minimum_tls_version, "1.3")
    use_32_bit_worker     = try(var.site_config.use_32_bit_worker, false)
    vnet_route_all_enabled = try(var.site_config.vnet_route_all_enabled, true)

    dynamic "ip_restriction" {
      for_each = try(var.site_config.ip_restrictions, [])
      content {
        ip_address = ip_restriction.value.ip_address
        action     = ip_restriction.value.action
      }
    }

    dynamic "scm_ip_restriction" {
      for_each = try(var.site_config.scm_ip_restrictions, [])
      content {
        ip_address = scm_ip_restriction.value.ip_address
        action     = scm_ip_restriction.value.action
      }
    }

    application_stack {
      python_version = try(var.site_config.python_version, "3.13")
    }

    application_insights_connection_string = try(var.site_config.application_insights_connection_string, null)

    cors {
      allowed_origins     = try(var.site_config.cors_allowed_origins, ["https://portal.azure.com"])
      support_credentials = try(var.site_config.cors_support_credentials, false)
    }
  }

  app_settings = merge(
    var.app_settings,
    var.storage_uses_managed_identity ? {
      "AzureWebJobsStorage__accountName" = var.storage_account_name
      "AzureWebJobsStorage__clientId"    = var.managed_identity_client_id
      "AzureWebJobsStorage__credential"  = "managedidentity"
      "AzureWebJobsServiceBus"           = var.service_bus_connection_string
    } : {}
  )

  lifecycle {
    ignore_changes = [
      tags["hidden-link: /app-insights-resource-id"],
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      app_settings,
      auth_settings_v2,
      sticky_settings
    ]
  }

  tags = var.tags
}

# Diagnostic settings for Function App
resource "azurerm_monitor_diagnostic_setting" "function_app" {
  name                       = "diag-${local.validated_name}"
  target_resource_id         = azurerm_linux_function_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Function App logs
  enabled_log {
    category = "FunctionAppLogs"
  }

  # Function App metrics
  enabled_metric {
    category = "AllMetrics"
  }
}