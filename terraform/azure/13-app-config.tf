locals {
  helm_path        = "../../helm/azure"
  helm_chart_files = fileset(local.helm_path, "**/*")
  helm_chart_hash  = sha256(join("", [for f in local.helm_chart_files : file("${local.helm_path}/${f}")]))
}

resource "helm_release" "my_app" {
  name             = local.project_name
  chart            = local.helm_path
  namespace        = local.namespace
  create_namespace = false

  force_update  = true
  recreate_pods = true



  set {
    name  = "chartHash"
    value = local.helm_chart_hash
  }


  set {
    name  = "projectName"
    value = local.project_name
  }

  set {
    name  = "namespace"
    value = "default"
  }

  # enabled azure/aws node and client

  set {
    name  = "cloudProvider.name"
    value = local.provider_name
  }

  set {
    name  = "cloudProvider.aws.enabled"
    value = local.provider_name == "aws" ? "true" : "false"
  }

  set {
    name  = "cloudProvider.azure.enabled"
    value = local.provider_name == "azure" ? "true" : "false"
  }


  /////////////////////////////////

  # port number
  set {
    name  = "currentPort"
    value = "4003"
  }
  set {
    name  = "healthPort"
    value = "4000"
  }
  set {
    name  = "stressPort"
    value = "4001"
  }
  set {
    name  = "nodePort"
    value = "4002"
  }
  set {
    name  = "clientPort"
    value = "3000"
  }

  # node enviroenment secret vairalbe
  set {
    name  = "deployment.node.clusterName"
    value = azurerm_kubernetes_cluster.aks.name
  }

  set {
    name  = "deployment.node.databaseUrl"
    value = local.database_url
  }

  set {
    name  = "deployment.node.subscriptionId"
    value = var.subscription_id
  }

  set {
    name  = "deployment.node.resourceGroupName"
    value = azurerm_resource_group.rg.name
  }
  set {
    name  = "deployment.node.clientId"
    value = azuread_application.app.client_id
  }

  set {
    name  = "deployment.node.clientSecret"
    value = azuread_application_password.secret.value
  }

  set {
    name  = "deployment.node.tenantId"
    value = var.tenant_id
  }

  # client enviroenment variables
  set {
    name  = "deployment.client.viteExternalUrl"
    value = "http://${local.external_url}"
  }

  # HPA
  set {
    name  = "hpa.enabled"
    value = "true"
  }

  set {
    name  = "hpa.minReplicas"
    value = "1"
  }

  set {
    name  = "hpa.maxReplicas"
    value = "10"
  }

  set {
    name  = "hpa.targetCPUUtilizationPercentage"
    value = "50"
  }


  # set {
  #   name  = "hpa.targetMemoryUtilizationPercentage"
  #   value = "70"
  # }

  depends_on = [helm_release.external_nginx]
}
