provider "azurerm" {
     features {} 
     }

module "StorageAccount" {
    source = "./../../modules/StorageAccount"
    environment = var.environment
    location = var.location
}