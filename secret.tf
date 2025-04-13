resource "azurerm_key_vault_secret" "this" {
  for_each = { for secret in var.secrets : secret.name => secret }

  name             = each.value.name
  value            = each.value.value
  key_vault_id     = azurerm_key_vault.this.id
  value_wo         = each.value.value_wo
  value_wo_version = each.value.value_wo_version
  content_type     = each.value.content_type
  not_before_date  = each.value.not_before_date
  expiration_date  = each.value.expiration_date
  tags             = merge(local.metadata.tags, each.value.tags)

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_key_vault_secret"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_key_vault_secret"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_key_vault_secret"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_key_vault_secret"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}