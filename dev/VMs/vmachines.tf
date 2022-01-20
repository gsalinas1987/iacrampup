provider "azurerm" {
     features {} 
     }

module "VirtualMachines" {
    source = "./../../modules/VirtualMachine"
    environment = var.environment
    location = var.location
    size = var.size_node
    subnet_id = var.subnet_id_node
    vm_name = var.vm_name_node
    vmnic_name = var.vmnic_name_node
}

module "VirtualMachines1" {
    source = "./../../modules/VirtualMachine"
    environment = var.environment
    location = var.location
    size = var.size_node1
    subnet_id = var.subnet_id_node1
    vm_name = var.vm_name_node1
    vmnic_name = var.vmnic_name_node1
}

module "VirtualMachines2" {
    source = "./../../modules/VirtualMachine"
    environment = var.environment
    location = var.location
    size = var.size_azapi
    subnet_id = var.subnet_id_azapi
    vm_name = var.vm_name_azapi
    vmnic_name = var.vmnic_name_azapi
}

resource "azurerm_network_interface" "vmnic_bastion" {
  name                = var.vmnic_name_bastion
  location            = var.location
  resource_group_name = "rg01-${var.environment}-gsv"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id_bastion
    private_ip_address_allocation = "Dynamic"
     public_ip_address_id          = data.azurerm_public_ip.Public_ip_add.id
  }
}

resource "azurerm_linux_virtual_machine" "vmbastionhost" {
  name                = var.vm_name_bastion
  resource_group_name = "rg01-${var.environment}-gsv"
  location            = var.location
  size                = var.size_bastion
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.vmnic_bastion.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
}