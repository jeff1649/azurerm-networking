resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  private_endpoint_network_policies = try(
    each.value.private_endpoint_network_policies,
    "Enabled"
  )

  dynamic "delegation" {
    for_each = try(each.value.delegations, {})

    content {
      name = delegation.key

      service_delegation {
        name    = delegation.value.name
        actions = try(delegation.value.actions, [])
      }
    }
  }
}
