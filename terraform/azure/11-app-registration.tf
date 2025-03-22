# Configure the Azure AD provider
provider "azuread" {
  # If environment variables are not set, tenant_id, client_id, client_secret can be specified here
  # Otherwise use Azure CLI authentication
  tenant_id = var.tenant_id
}


resource "azuread_application" "app" {
  display_name = "${local.project_name}-app-registrations"

  depends_on = [azurerm_kubernetes_cluster.aks]
}
resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
}

resource "azuread_application_password" "secret" {

  application_id = azuread_application.app.id
  end_date       = timeadd(timestamp(), "24h")
}

resource "azuread_application_owner" "sp_owner" {
  application_id  = azuread_application.app.id
  owner_object_id = azuread_service_principal.sp.object_id
}

# # Create UAMI
# resource "azurerm_user_assigned_identity" "aks_identity" {
#   name                = "${local.project_name}-app-owner"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
# }

# Assign roles to UAMI (e.g. application-related permissions)
resource "azurerm_role_assignment" "sp_monitoring_reader" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azuread_service_principal.sp.object_id
}


