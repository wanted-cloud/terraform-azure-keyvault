resource "azurerm_key_vault_certificate" "this" {
  for_each     = { for cert in var.certificates : cert.name => cert if cert.contents != "" }
  name         = each.value.name
  key_vault_id = azurerm_key_vault.this.id

  dynamic "certificate" {
    for_each = each.value.contents != "" ? [each.value] : []
    content {
      contents = certificate.value.contents
      password = certificate.value.password
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_key_vault_certificate"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_key_vault_certificate"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_key_vault_certificate"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_key_vault_certificate"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}