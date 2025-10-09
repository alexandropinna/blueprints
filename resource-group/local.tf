locals {
  # Nomenclature: rg-<cl>-<env>-<reg>-<comp>-<stamp>-<inst>
  name = "rg-${var.client_code}-${var.environment}-${var.region_short}-${var.component}-${var.stamp}-${format("%02d", random_integer.priority.result % 100)}"

  # Validated name (max 80 characters)
  validated_name = length(local.name) > 80 ? substr(local.name, 0, 80) : local.name
}