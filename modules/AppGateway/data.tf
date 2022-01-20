data "azurerm_virtual_network" "azvnet" { 
    name = "az01-${var.environment}-vngsv" 
    resource_group_name = "rg01-${var.environment}-gsv"
}

data "azurerm_subnet" "frontendsn" {
  name                 = "pubsubnet01gsv"
  resource_group_name  = "rg01-${var.environment}-gsv"
  virtual_network_name = "az01-${var.environment}-vngsv"
}

data "azurerm_subnet" "backendsn" {
  name                 = "privsubnet01gsv"
  resource_group_name  = "rg01-${var.environment}-gsv"
  virtual_network_name = "az01-${var.environment}-vngsv"
}

data "azurerm_subnet" "appgatewaysn" {
  name                 = "appgwsubnet01gsv"
  resource_group_name  = "rg01-${var.environment}-gsv"
  virtual_network_name = "az01-${var.environment}-vngsv"
}

data "azurerm_public_ip" "Public_ip_appgw" {
    name = "AppgwPublicIP"
    resource_group_name = "rg01-${var.environment}-gsv"
}
