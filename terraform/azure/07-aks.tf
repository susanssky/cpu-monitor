resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.project_name}-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${local.project_name}-aks"

  default_node_pool {
    name                 = "general"
    node_count           = 1
    vm_size              = "Standard_B2s"
    vnet_subnet_id       = azurerm_subnet.public[0].id
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 5

    node_labels = {
      role = "general"
    }
  }
  sku_tier = "Free"

  identity {
    type = "SystemAssigned"
  }

  # identity {
  #   type         = "UserAssigned"
  #   identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  # }


  # # Enable OIDC Issuer, which is the basis for Azure Workload Identity
  # oidc_issuer_enabled       = true
  # workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.1.0.0/16"
    dns_service_ip = "10.1.0.10"
  }

  tags = {
    Name = "${local.project_name}-aks"
  }


  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }


}


