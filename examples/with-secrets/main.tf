module "example" {
    source = "../.."

    name = "example-keyvault"
    resource_group_name = "test"

    secrets = [{
      name = "test"
      // Please note this is an example, 
      // do not use secret hardcoded values in production
      value_wo = "test-super-secret-value"
        value_wo_version = "1.0"
    }]
    
}