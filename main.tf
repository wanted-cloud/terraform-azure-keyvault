/*
 * # wanted-cloud/terraform-azure-keyvault
 * 
 * Terraform building block module for management of Azure Keyvault.
 */

resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = var.public_network_access_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled

  enable_rbac_authorization = var.enable_rbac_authorization

  sku_name = var.sku_name

  tags = merge(local.metadata.tags, var.tags)

  // We are using isolated resource therefore this is commented and must stay!
  //access_policy {}

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [1] : []
    content {
      default_action             = var.network_acls.default_action
      bypass                     = var.network_acls.bypass
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_key_vault"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_key_vault"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_key_vault"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_key_vault"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}