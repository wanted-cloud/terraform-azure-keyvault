module "example" {
    source = "../.."

    name = "example-keyvault"
    resource_group_name = "test"
    
    certificates = [{
      name = "test"
      contents = filebase64("test.pfx")
      password = "test-password"
    }]
}