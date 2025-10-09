resource "random_integer" "priority" {
  min = 1
  max = 99
}

resource "azurerm_resource_group" "this" {
  name     = var.name == "" ? local.name : var.name
  location = var.location
  tags     = var.tags
}
resource "azurerm_management_lock" "group" {
  count      = var.lock_count
  lock_level = var.lock_level
  name       = "${azurerm_resource_group.this.name}-lock"
  scope      = azurerm_resource_group.this.id
}
