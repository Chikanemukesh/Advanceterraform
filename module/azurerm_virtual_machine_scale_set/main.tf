resource "azurerm_linux_virtual_machine_scale_set" "frontend_vmss" {
  for_each = var.frontend_vmss

  name                = each.value.vname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  instances           = each.value.instances
  upgrade_mode        = "Manual"

  admin_username = "adminuser"
  admin_password = "Password@123"

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku = "20_04-lts-gen2"

    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = each.value.nicname
    primary = true

    ip_configuration {
      name      = each.value.ipname
      subnet_id = data.azurerm_subnet.subnet_block[each.key].id
      primary   = true
    }
  }

  computer_name_prefix            = "frontendvm"
  disable_password_authentication = false
}
# mukesh