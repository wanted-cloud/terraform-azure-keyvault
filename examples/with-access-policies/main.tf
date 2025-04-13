data "azuread_service_principal" "example" {
  client_id = "//Service principal client id"
}

module "example" {
    source = "../.."

    name = "example-keyvault"
    resource_group_name = "test"

    access_policies = [{
        name                    = "example-access-policy"
        object_id               = data.azuread_service_principal.example.object_id
        key_permissions         = ["Get", "List"]
        secret_permissions      = ["Get", "List"]
        certificate_permissions = ["Get", "List"]
        storage_permissions     = ["Get", "List"]
    }]
    
}