resource "azapi_resource" "this" {
  for_each = var.api_connections

  type      = "Microsoft.Web/connections@2018-07-01-preview"
  name      = "${each.key}-${local.client_code}-${local.environment}-${local.region_short}-${var.component}-${var.stamp}-${local.instance_number}"
  location  = data.azurerm_resource_group.this.location
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"

  body = jsonencode({
    properties = merge(
      {
        displayName = each.value.display_name
        api = {
          id = data.azurerm_managed_api.apis[each.key].id
        }
      },
      # Add parameterValueSet for Managed Identity authentication
      each.value.use_managed_identity ? {
        parameterValueSet = {
          name   = "managedIdentityAuth"
          values = {}
        }
      } : {},
      # Add parameterValues for custom authentication (e.g., OAuth)
      length(each.value.parameter_values) > 0 ? {
        parameterValues = each.value.parameter_values
      } : {}
    )
  })

  tags = var.tags

  # Disable schema validation as parameterValueSet is not in all API versions
  schema_validation_enabled = false

  # For OAuth-based connections, ignore parameter changes
  lifecycle {
    ignore_changes = [body]
  }
}
