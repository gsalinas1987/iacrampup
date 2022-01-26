terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg01-dev-gsv"
        storage_account_name = "az01devsa"
        container_name       = "az01-test-tfstate"
        key                  = "test/terraform.tfstate"
    }

}

provider "azurerm" {
     features {} 
     }

    
resource "azurerm_virtual_network" "azvnet1" {
  name                = "az01-dev-vngsv1"
  resource_group_name = "rg01-dev-gsv"
  location            = "East US"
  address_space       = ["192.168.0.0/16"]
}