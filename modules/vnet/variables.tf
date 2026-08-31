variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "location" {
  description = "Azure region where the VNet will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the VNet will be created."
  type        = string
}

variable "address_space" {
  description = "Address space assigned to the VNet."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create."

  type = map(object({
    name             = string
    address_prefixes = list(string)

    private_endpoint_network_policies = optional(string, "Enabled")

    delegations = optional(map(object({
      name    = string
      actions = optional(list(string), [])
    })), {})
  }))
}

variable "tags" {
  description = "Tags applied to the VNet."
  type        = map(string)
  default     = {}
}
