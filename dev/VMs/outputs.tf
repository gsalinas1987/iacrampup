output "Node_IP_Address" {
    value = "${module.VirtualMachines.Node_private_IP_Address}"
}

output "Node1_IP_Address" {
    value = "${module.VirtualMachines1.Node_private_IP_Address}"
}

output "VMAppi_IP_Address" {
    value = "${module.VirtualMachines2.Node_private_IP_Address}"
}

