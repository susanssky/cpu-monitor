
resource "azurerm_subnet" "public" {
  count                = local.subnet_number
  name                 = "${local.project_name}-public-subnet${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.${(count.index + 1) * 10}.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "private" {
  count                = local.subnet_number
  name                 = "${local.project_name}-private-subnet${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.${(count.index + 3) * 10}.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]


  delegation {
    name = "postgres_delegation"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

