output "Subnet_Frontend" {
  value = "${azurerm_subnet.frontendsn.id}"
}
output "Subnet_Backend" {
  value = "${azurerm_subnet.backendsn.id}"
}
output "Subnet_Appgtw" {
  value = "${azurerm_subnet.appgatewaysn.id}"
}
