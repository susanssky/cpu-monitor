locals {
  helm_ing_path       = "../../helm/aws-ingress"
  helm_chart_ing_file = "templates/ingress.yaml"
  helm_chart_ing_hash = sha256(file("${local.helm_ing_path}/${local.helm_chart_ing_file}"))
}

resource "helm_release" "my_app_ingress" {
  name             = "${local.project_name}-ingress"
  chart            = local.helm_ing_path
  namespace        = local.namespace
  create_namespace = false


  force_update  = true
  recreate_pods = true

  set {
    name  = "chartHash"
    value = local.helm_chart_ing_hash
  }

  set {
    name  = "projectName"
    value = local.project_name
  }

  set {
    name  = "namespace"
    value = local.namespace
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


  depends_on = [helm_release.alb]
}
