terraform {
  required_version = "0.12.31"

  backend "azurerm" {
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Login credential should be given to this provides by environment variables: ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID
  version = "1.33.1"
}
