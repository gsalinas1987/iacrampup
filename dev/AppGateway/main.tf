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