resource "azurerm_key_vault_access_policy" "this" {
  for_each = { for policy in var.access_policies : policy.name => policy }

  key_vault_id   = azurerm_key_vault.this.id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  object_id      = each.value.object_id
  application_id = try(each.value.application_id, null)

  certificate_permissions = each.value.certificate_permissions != null ? each.value.certificate_permissions : []
  storage_permissions     = each.value.storage_permissions != null ? each.value.storage_permissions : []
  key_permissions         = each.value.key_permissions != null ? each.value.key_permissions : []
  secret_permissions      = each.value.secret_permissions != null ? each.value.secret_permissions : []

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_key_vault_access_policy"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_key_vault_access_policy"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_key_vault_access_policy"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_key_vault_access_policy"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}