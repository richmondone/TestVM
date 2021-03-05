provider "azurerm" {
    features {}
        
    subscription_id = "4e9802df-cff3-487a-94d4-222c2d576861"
}

data "azurerm_client_config" "current" {}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_resource_group" "qaiiqrg" {
    name                  = "qa-iiq-rg"
    location              = "eastus"

    tags = "${var.required_tags}"
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "canadaonevault786"
  location                    = "${var.location}"
  resource_group_name         = "${azurerm_resource_group.qaiiqrg.name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "${data.azurerm_client_config.current.tenant_id}"
  //soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${data.azurerm_client_config.current.object_id}"

       key_permissions = [
      "create",
      "get",
      "list"
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "purge",
      "recover",
      "list"
    ]
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "azadmin"
  value        = "${random_password.password.result}"
  key_vault_id = "${azurerm_key_vault.keyvault.id}"
}

  data "azurerm_subnet" "subnet" {
  name                 = "Windows-Trusted-Subnet"
  resource_group_name  = "MYVMs"
  virtual_network_name = "OneNet-VirtualNetwork"

  //depends_on = ["azurerm_virtual_network.network"]
  
  }
  resource "azurerm_network_interface" "interface" {
  count               = "${var.numberOfVM}"
  name                = "${var.vmname}-${count.index+1}-eth01"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.qaiiqrg.name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${data.azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }

    dns_servers = ["8.8.8.8", "8.8.8.8"]

}

resource "azurerm_managed_disk" "disk" {
    name = "qa-iiq-vm-manageddisk-${count.index+1}"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.qaiiqrg.name}"
    storage_account_type = "Standard_LRS"
    create_option = "Empty"
    disk_size_gb = 10
}

resource "azurerm_virtual_machine" "virtualmachine" {

# Virtual Machine INFRASTRUCUTRE SETTIGNS
    count = "${var.numberOfVM}"
    name = "${var.vmname}-${count.index+1}"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.qaiiqrg.name}"
    network_interface_ids = ["${element(azurerm_network_interface.interface.*.id, count.index+1)}"]
    vm_size = "Standard_B2ms"
    delete_data_disks_on_termination = true

# WHICH OS THE VM WILL HAVE
  storage_image_reference {
    publisher         = "MicrosoftWindowsServer"
    offer             = "WindowsServer"
    sku               =  "2016-Datacenter"
    version           = "latest"
  }

  storage_os_disk {
    name              = "${var.vmname}-${count.index+1}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = "127" # At least 127 Gb
  }

  storage_data_disk {
    name = "${var.vmname}-${count.index+1}-datadisk"
    lun = 1
    managed_disk_type = "Standard_LRS"
    create_option = "Empty"
    disk_size_gb = 10
  }
 
# PROFILE OF THE VM - USER / PASSWORD
    os_profile {
        computer_name = "${var.vmname}-${count.index+1}"
        admin_username = "azadmin"
        admin_password = "Password123!!"
    }

     os_profile_windows_config {   
    }

# TAGS - KEY / VALUE PAIRS
   tags = "${var.required_tags}"
}

output "Virtual Machine Name" {value = "${azurerm_virtual_machine.virtualmachine.*.name}"}

output " Virtual Machine Location" {value = "{azurerm_virtual_machine.virtualmachine.location}"}

output "Virtual Network Name" {value = "${azurerm_network_interface.interface.*.name}"}

output "Your Secret Value" {value = "${azurerm_key_vault_secret.secret.value}"}
output "Your Secret Name" {value = "${random_password.password.result}"}


//output "VM IP Address" {value = "${azurerm_subnet.subnet.*.name}"}