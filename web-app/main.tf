resource "azurerm_linux_web_app" "this" {
  name                = local.name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.this.location
  service_plan_id     = var.service_plan_id

  https_only              = var.https_only
  client_affinity_enabled = var.client_affinity_enabled

  client_certificate_enabled = var.client_certificate_enabled
  client_certificate_mode     = var.client_certificate_mode

  public_network_access_enabled = var.public_network_access_enabled

  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  site_config {
    ftps_state          = try(var.site_config.ftps_state, "FtpsOnly")
    minimum_tls_version = try(var.site_config.minimum_tls_version, "1.3")
    always_on           = try(var.site_config.always_on, true)
    http2_enabled       = try(var.site_config.http2_enabled, true)

    application_stack {
      node_version = try(var.site_config.node_version, "22-lts")
    }

    # GitHub IP restrictions
    dynamic "ip_restriction" {
      for_each = try(var.site_config.enable_github_ip_restrictions, false) ? local.github_ip_ranges : []
      content {
        ip_address = ip_restriction.value
        action     = "Allow"
        priority   = 100 + ip_restriction.key
        name       = "github-actions-${ip_restriction.key}"
      }
    }

    # Custom IP restrictions
    dynamic "ip_restriction" {
      for_each = try(var.site_config.custom_ip_restrictions, [])
      content {
        ip_address = ip_restriction.value.ip_address
        action     = ip_restriction.value.action
        priority   = ip_restriction.value.priority
        name       = ip_restriction.value.name
      }
    }

    # Set default action based on GitHub restrictions or custom setting
    ip_restriction_default_action = try(var.site_config.enable_github_ip_restrictions, false) ? "Deny" : try(var.site_config.ip_restriction_default_action, "Allow")
  }

  dynamic "auth_settings" {
    for_each = var.auth_settings != null && var.auth_settings.enabled ? [var.auth_settings] : []
    content {
      enabled                       = auth_settings.value.enabled
      default_provider              = auth_settings.value.default_provider
      unauthenticated_client_action = auth_settings.value.unauthenticated_client_action
      token_store_enabled           = auth_settings.value.token_store_enabled
      issuer                        = auth_settings.value.issuer

      dynamic "active_directory" {
        for_each = auth_settings.value.active_directory != null ? [auth_settings.value.active_directory] : []
        content {
          client_id                  = active_directory.value.client_id
          client_secret_setting_name = active_directory.value.client_secret_setting_name
          allowed_audiences          = active_directory.value.allowed_audiences
        }
      }
    }
  }

  app_settings = merge(
    var.app_settings,
    var.application_insights_connection_string != null ? {
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.application_insights_connection_string
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
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

# Diagnostic settings for Web App
resource "azurerm_monitor_diagnostic_setting" "web_app" {
  name                       = "diag-${local.validated_name}"
  target_resource_id         = azurerm_linux_web_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Web App logs
  enabled_log {
    category = "AppServiceHTTPLogs"
  }

  enabled_log {
    category = "AppServiceConsoleLogs"
  }

  enabled_log {
    category = "AppServiceAppLogs"
  }

  enabled_log {
    category = "AppServiceAuditLogs"
  }

  enabled_log {
    category = "AppServiceIPSecAuditLogs"
  }

  enabled_log {
    category = "AppServicePlatformLogs"
  }

  # Web App metrics
  enabled_metric {
    category = "AllMetrics"
  }
}