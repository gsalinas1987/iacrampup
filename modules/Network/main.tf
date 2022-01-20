provider "azurerm" {
     features {} 
     }


resource "azurerm_virtual_network" "azvnet" {
  name                = "az01-${var.environment}-vngsv"
  resource_group_name = "rg01-${var.environment}-gsv"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "frontendsn" {
  name                 = "pubsubnet01gsv"
  resource_group_name  = "rg01-${var.environment}-gsv"
  virtual_network_name = azurerm_virtual_network.azvnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "backendsn" {
  name                 = "privsubnet01gsv"
  resource_group_name  = "rg01-${var.environment}-gsv"
  virtual_network_name = azurerm_virtual_network.azvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "appgatewaysn" {
  name                 = "appgwsubnet01gsv"
  resource_group_name  = "rg01-${var.environment}-gsv"
  virtual_network_name = azurerm_virtual_network.azvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "bastionpublicip" {
    name                         = "BastionPublicIP"
    location                     = var.location
    resource_group_name          = "rg01-${var.environment}-gsv"
    allocation_method            = "Dynamic"
}

resource "azurerm_public_ip" "appgwpublicip" {
    name                         = "AppgwPublicIP"
    location                     = var.location
    resource_group_name          = "rg01-${var.environment}-gsv"
    allocation_method            = "Dynamic"
}