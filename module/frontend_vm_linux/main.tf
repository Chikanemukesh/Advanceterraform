resource "azurerm_network_interface" "nic_block" {
  for_each            = var.frontend_vm
  name                = each.value.nicname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {

    name                          = each.value.ipname
    subnet_id                     = data.azurerm_subnet.subnet_block[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_block" {
  for_each            = var.frontend_vm
  name                = each.value.vname
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  disable_password_authentication= false
  size                  = "Standard_F2"
  admin_username        = "chikanevm"
  admin_password        = "chikane@125"
  network_interface_ids = [azurerm_network_interface.nic_block[each.key].id,]
 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
