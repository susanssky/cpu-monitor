# # Azure Managed Identity
# resource "azurerm_user_assigned_identity" "aks_identity" {
#   name                = "${local.project_name}-sa"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
# }

# resource "azurerm_role_assignment" "net_contributor" {
#   scope                = azurerm_resource_group.rg.id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
# }

# # Associate a Service Account with a Federated Identity Credential
# resource "azurerm_federated_identity_credential" "pod_identity" {
#   name                = "${local.project_name}-pod-federated-identity"
#   resource_group_name = azurerm_resource_group.rg.name
#   audience            = ["api://AzureADTokenExchange"]
#   issuer              = azurerm_kubernetes_cluster.aks.oidc_issuer_url
#   parent_id           = azurerm_user_assigned_identity.aks_identity.id
#   subject             = "system:serviceaccount:default:${azurerm_user_assigned_identity.aks_identity.name}"
# }
