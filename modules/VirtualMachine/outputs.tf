output "Node_private_IP_Address" {
    value = "${azurerm_network_interface.vmnic.private_ip_address}"
}

