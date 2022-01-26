provider "azurerm" {
     features {} 
     }


#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${data.azurerm_virtual_network.azvnet.name}-beap"
  frontend_port_name             = "${data.azurerm_virtual_network.azvnet.name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_virtual_network.azvnet.name}-feip"
  http_setting_name              = "${data.azurerm_virtual_network.azvnet.name}-be-htst"
  listener_name                  = "${data.azurerm_virtual_network.azvnet.name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_virtual_network.azvnet.name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_virtual_network.azvnet.name}-rdrcfg"
}

resource "azurerm_application_gateway" "appgateway" {
  name                = "az01appgateway"
  resource_group_name = "rg01-${var.environment}-gsv"
  location            = var.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.appgatewaysn.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 3030
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.Public_ip_appgw.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    ip_addresses = ["${var.ip1}", "${var.ip2}"] 
    }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 3030
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}