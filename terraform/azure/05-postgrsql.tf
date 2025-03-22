# Create a private DNS zone (required for Flexible Server)
resource "azurerm_private_dns_zone" "postgres" {
  name                = "${local.project_name}.private.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_virtual_network.vnet]
}

# Associate a private DNS zone with a VNet
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "${local.project_name}-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_postgresql_flexible_server" "database" {
  name                = "${local.project_name}-psql"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


  sku_name = "B_Standard_B1ms" # Burstable SKU, 1 vCore, 2 GiB RAM


  storage_mb = 32768 # 32 GiB (1 GiB = 1024 MB)


  version = "16"


  administrator_login    = var.database_username
  administrator_password = var.database_password

  zone = "1"


  public_network_access_enabled = false
  delegated_subnet_id           = azurerm_subnet.private[0].id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id


  tags = {
    Name = "${local.project_name}-psql"
  }
  depends_on = [azurerm_subnet.private, azurerm_virtual_network.vnet]
}
