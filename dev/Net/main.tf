terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.92.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg01-dev-gsv"
        storage_account_name = "az01devsa"
        container_name       = "az01-dev-tfstateblob"
        key                  = "dev/Net/terraform.tfstate"
    }

}
provider "azurerm" {
     features {} 
     }


module "Network" {
    source = "./../../modules/Network"
    environment = var.environment
    location = var.location
}