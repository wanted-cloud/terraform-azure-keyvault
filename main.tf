/*
 * # wanted-cloud/terraform-azure-keyvault
 * 
 * Terraform building block module for management of Azure Keyvault.
 */

resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = data.azurerm_resource_group.this.location
  resource_group_name             = data.azurerm_resource_group.this.name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled

  enable_rbac_authorization = var.enable_rbac_authorization

  sku_name = var.sku_name

  tags = merge(local.metadata.tags, var.tags)

  network_acls {
    default_action             = var.network_acls.default_action
    bypass                     = var.network_acls.bypass
    ip_rules                   = var.network_acls.ip_rules
    virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
  }

}