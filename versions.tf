terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

backend "azurerm" {
  resource_group_name  = "rg-terraform-state"
  storage_account_name = "stterraformstatepoc001"
  container_name       = "state"
  key                  = "azurerm-networking.tfstate"

  use_oidc       = true
  use_azuread_auth = true
    }
}