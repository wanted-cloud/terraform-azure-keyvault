variable "name" {
  description = "Name of the Azure Keyvault."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the Azure Keyvault will be created."
  type        = string
}

variable "location" {
  description = "Location of the resource group in which the Azure Keyvault will be created, if not set it will be the same as the resource group."
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "SKU name for the Key Vault. Possible values are 'standard' and 'premium'."
  type        = string
  default     = "standard"
}

variable "enable_rbac_authorization" {
  description = "Enable RBAC authorization for the Key Vault."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled for the Key Vault."
  type        = bool
  default     = false

}

variable "soft_delete_retention_days" {
  description = "The number of days that the Key Vault and its objects are retained after deletion."
  type        = number
  default     = 7
}

variable "enabled_for_deployment" {
  description = "Whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Whether Azure Virtual Machines are permitted to use the key vault for disk encryption."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}

}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "network_acls" {
  description = "Network ACLs for the Key Vault."
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null

}

variable "access_policies" {
  description = "List of access policies for the Key Vault."
  type = list(object({
    name                    = string
    object_id               = string
    application_id          = optional(string)
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    certificate_permissions = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  default = []
}

variable "secrets" {
  description = "List of secrets to create in the Key Vault."
  type = list(object({
    name             = string
    value            = optional(string)
    value_wo         = optional(string)
    value_wo_version = optional(string)
    content_type     = optional(string)
    not_before_date  = optional(string)
    expiration_date  = optional(string)
    tags             = optional(map(string), {})
  }))
  default = []
}