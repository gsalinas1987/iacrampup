provider "azurerm" {
     features {} 
     }


module "Network" {
    source = "./../../modules/Network"
    environment = var.environment
    location = var.location
}