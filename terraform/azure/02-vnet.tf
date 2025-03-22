# Azure Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.project_name}-vnet"
  address_space       = [local.vnet_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
