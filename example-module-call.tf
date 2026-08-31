module "network" {
  source = "./modules/vnet"

  vnet_name           = "vnet-tf-test"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  address_space = [
    "10.10.0.0/16"
  ]

  subnets = {
    apps = {
      name = "snet-apps"

      address_prefixes = [
        "10.10.1.0/24"
      ]
    }

    private_endpoints = {
      name = "snet-private-endpoints"

      address_prefixes = [
        "10.10.2.0/24"
      ]

      private_endpoint_network_policies = "Disabled"
    }
  }

  tags = {
    environment = "test"
    managed_by  = "terraform"
  }
}
