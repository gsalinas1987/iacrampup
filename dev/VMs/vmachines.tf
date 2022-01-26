terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.92.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "rg01-dev-gsv"
        storage_account_name = "az01devsa"
        container_name       = "az01-dev-tfstateblob"
        key                  = "dev/VMs/terraform.tfstate"
    }

}
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

# Create Network Security Group and rule
resource "azurerm_network_security_group" "bastionsg" {
    name                = "bastion-${var.environment}-sg"
    location            = var.location
    resource_group_name = "rg01-${var.environment}-gsv"

    security_rule {
        name                       = "SSH"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
	security_rule {
        name                       = "Jenkins"
        priority                   = 301
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
	security_rule {
        name                       = "Grafana"
        priority                   = 302
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3000"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
	
    tags = {
        environment = "Terraform NSG Demo"
    }
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

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg-vnic-assoc" {
    network_interface_id      = azurerm_network_interface.vmnic_bastion.id
    network_security_group_id = azurerm_network_security_group.bastionsg.id
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