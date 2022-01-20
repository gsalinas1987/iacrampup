############ Storage Account ############
resource "azurerm_storage_account" "storageaccount" {
  name                     = "az01${var.environment}sa"
  location                 = var.location
  resource_group_name      = "rg01-${var.environment}-gsv"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.environment}"
  }
}