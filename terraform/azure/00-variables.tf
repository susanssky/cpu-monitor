locals {
  project_name  = "cpu-monitor"
  namespace     = "default"
  provider_name = "azure"

  anyone_access_ip = "0.0.0.0/0"
  vnet_cidr        = "10.0.0.0/16"
  subnet_number    = 2
  database_url     = "postgresql://${azurerm_postgresql_flexible_server.database.administrator_login}:${azurerm_postgresql_flexible_server.database.administrator_password}@${azurerm_postgresql_flexible_server.database.fqdn}:5432/postgres?sslmode=require"
  external_url = try(data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].hostname != ""
    ? data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].hostname
    : data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip,
  "LoadBalancer IP not yet assigned")
}
variable "tenant_id" {}
variable "subscription_id" {}
variable "database_username" {}
variable "database_password" {}

