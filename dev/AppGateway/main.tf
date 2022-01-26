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
        key                  = "dev/AppGateway/terraform.tfstate"
    }

}
provider "azurerm" {
     features {} 
     }


module "Application_Gateway" {
    source = "./../../modules/AppGateway"
    environment = var.environment
    location = var.location
    ip1 = var.ip1
    ip2 = var.ip2
}