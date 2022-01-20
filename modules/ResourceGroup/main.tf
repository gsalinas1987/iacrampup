provider "azurerm" {
     features {} 
     }

resource "azurerm_resource_group" "gsalinas-rg" {
  name     = "rg01-${var.environment}-gsv"
  location = var.location
}