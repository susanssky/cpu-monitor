

# output "cluster_name" {
#   value = azurerm_kubernetes_cluster.aks.name
# }


# output "database_url" {
#   value = nonsensitive(local.database_url)
#   # sensitive = true
# }


# output "app_client_id" {
#   value = azuread_application.app.client_id
# }
# output "app_client_secret" {
#   value = nonsensitive(azuread_application_password.secret.value)
# }
output "load_balancer_external_link" {
  value = local.external_url

}
