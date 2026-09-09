variable "app_abbreviation" {
  description = "Abbreviated application name used in the virtual network name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.app_abbreviation))
    error_message = "app_abbreviation must contain only lowercase letters and numbers."
  }
}

variable "environment" {
  description = "Environment name used in resource naming."
  type        = string

  validation {
    condition     = contains(["poc", "dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: poc, dev, test, prod."
  }
}

variable "subscription" {
  description = "Subscription abbreviation used in resource naming."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.subscription))
    error_message = "subscription must contain only lowercase letters and numbers."
  }
}

variable "instance" {
  description = "Instance number for the virtual network."
  type        = number
  default     = 1

  validation {
    condition     = var.instance >= 1 && var.instance <= 999
    error_message = "instance must be between 1 and 999."
  }
}

variable "location" {
  description = "Azure region where networking resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where networking resources will be created."
  type        = string
}

variable "address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to create."

  type = map(object({
    purpose          = string
    instance         = optional(number, 1)
    address_prefixes = list(string)

    private_endpoint_network_policies = optional(string, "Enabled")

    delegations = optional(map(object({
      name    = string
      actions = optional(list(string), [])
    })), {})
  }))
}

variable "tags" {
  description = "Tags applied to the virtual network."
  type        = map(string)
  default     = {}
}