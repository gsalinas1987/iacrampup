terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.93.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg01-dev-gsv"
        storage_account_name = "az01devsa"
        container_name       = "az01-dev-tfstateblob"
        key                  = "dev/mysql/terraform.tfstate"
    }

}
provider "azurerm" {
     features {} 
     }

resource "azurerm_mysql_server" "mysqldb" {
  name                = "mysqlgsv1"
  location            = var.location
  resource_group_name = "rg01-${var.environment}-gsv"

  administrator_login          = "applicationuser"
  administrator_login_password = "Application!"

  sku_name   = "B_Gen5_1"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
}
resource "azurerm_mysql_firewall_rule" "fw_rule" {
  name                = "office"
  resource_group_name = "rg01-${var.environment}-gsv"
  server_name         = "${azurerm_mysql_server.mysqldb.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}