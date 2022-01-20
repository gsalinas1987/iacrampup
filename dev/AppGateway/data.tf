data "azurerm_public_ip" "Public_ip_appgw" {
    name = "AppgwPublicIP"
    resource_group_name = "rg01-${var.environment}-gsv"
}