provider "azurerm" {
     features {} 
     }

module "Resources" {
    source = "./../../modules/ResourceGroup"
    environment = var.environment
    location = var.location
}