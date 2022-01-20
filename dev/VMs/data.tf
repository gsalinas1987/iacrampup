data "azurerm_public_ip" "Public_ip_add" {
    name = "BastionPublicIP"
    resource_group_name = "rg01-${var.environment}-gsv"
}

