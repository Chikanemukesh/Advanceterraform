data "azurerm_subnet" "subnet_block" {
  for_each             = var.frontend_vmss
  name                 = each.value.subnetname
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
