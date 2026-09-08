module "network" {
  source = "./modules/vnet"

  vnet_name           = "vnet-tf-test"
  location            = "centralus"
  resource_group_name = "rg-terraform-test-poc"

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