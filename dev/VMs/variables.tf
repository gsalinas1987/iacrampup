variable "environment" {
    default = "dev"
    }
variable "location" {
    default = "East US"
}
variable "size_bastion" {
    default = "Standard_B1ms"
}
variable "subnet_id_bastion" {
    default = "/subscriptions/1afd90be-5a70-487b-83b4-88571e23e1ee/resourceGroups/rg01-dev-gsv/providers/Microsoft.Network/virtualNetworks/az01-dev-vngsv/subnets/pubsubnet01gsv"
}
variable "vm_name_bastion" {
    default = "az01vmbastion"
}
variable "vmnic_name_bastion" {
   default = "vmnic_bastion"
}
## Node0 VM variables ##
variable "size_node" {
    default = "Standard_B1s"
}
variable "subnet_id_node" {
    default = "/subscriptions/1afd90be-5a70-487b-83b4-88571e23e1ee/resourceGroups/rg01-dev-gsv/providers/Microsoft.Network/virtualNetworks/az01-dev-vngsv/subnets/pubsubnet01gsv"
}
variable "vm_name_node" {
    default = "az01vmnode"
}

variable "vmnic_name_node" {
   default = "vmnic_node"
}
## Node1 VM variables ##
variable "size_node1" {
    default = "Standard_B1s"
}
variable "subnet_id_node1" {
    default = "/subscriptions/1afd90be-5a70-487b-83b4-88571e23e1ee/resourceGroups/rg01-dev-gsv/providers/Microsoft.Network/virtualNetworks/az01-dev-vngsv/subnets/pubsubnet01gsv"
}
variable "vm_name_node1" {
    default = "az01vmnode1"
}
variable "vmnic_name_node1" {
   default = "vmnic_node1"
}
## API VM variables ##
variable "size_azapi" {
    default = "Standard_B1s"
}
variable "subnet_id_azapi" {
    default = "/subscriptions/1afd90be-5a70-487b-83b4-88571e23e1ee/resourceGroups/rg01-dev-gsv/providers/Microsoft.Network/virtualNetworks/az01-dev-vngsv/subnets/privsubnet01gsv"
}
variable "vm_name_azapi" {
    default = "az01vmapi"
}
variable "vmnic_name_azapi" {
   default = "vmnic_azapi"
}