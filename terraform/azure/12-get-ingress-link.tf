provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
}

resource "time_sleep" "wait_for_ingress_controller" {
  depends_on      = [helm_release.external_nginx]
  create_duration = "100s"
}
data "kubernetes_service" "nginx_ingress_controller" {
  metadata {
    name      = "external-ingress-nginx-controller" # Helm release name + ingress-nginx-controller
    namespace = "ingress-basic"                     # Same as the namespace of helm_release
  }
  depends_on = [time_sleep.wait_for_ingress_controller, helm_release.external_nginx]
}


