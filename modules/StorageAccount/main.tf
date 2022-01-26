provider "azurerm" {
  features {}
}
############ Storage Account ############
resource "azurerm_storage_account" "storageaccount" {
  name                     = "az01${var.environment}sa"
  location                 = var.location
  resource_group_name      = "rg01-${var.environment}-gsv"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "${var.environment}"
  }
}
## Create a Blob Container to store the Terraform state files ##
resource "azurerm_storage_container" "tfstate_store" {
  name                  = "az01-${var.environment}-tfstateblob"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "blob"
}
