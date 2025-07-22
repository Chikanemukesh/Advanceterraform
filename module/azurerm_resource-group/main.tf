resource "azurerm_resource_group" "rg_block" {
  for_each = var.dev-aks-rg
  name     = each.value.name
  location = each.value.location
}
