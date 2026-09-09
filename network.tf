locals {
  vnet_name = format(
    "vnet-%s-%s-%s-%03d",
    var.app_abbreviation,
    var.environment,
    var.subscription,
    var.instance
  )
}

resource "azurerm_virtual_network" "this" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = var.tags

}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name = format(
    "snet-%s-%s-%s-%03d",
    each.value.purpose,
    var.environment,
    var.subscription,
    try(each.value.instance, 1)
  )

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
      name = delegation.keyconnection

      service_delegation {
        name    = delegation.value.name
        actions = try(delegation.value.actions, [])
      }
    }
  }
}

