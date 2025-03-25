locals {
  helm_app_path        = "../../helm/aws"
  helm_chart_app_files = fileset(local.helm_app_path, "**/*")
  helm_chart_app_hash  = sha256(join("", [for f in local.helm_chart_app_files : file("${local.helm_app_path}/${f}")]))

}

resource "helm_release" "my_app" {
  name             = local.project_name
  chart            = local.helm_app_path
  namespace        = local.namespace
  create_namespace = false


  force_update  = true
  recreate_pods = true

  set {
    name  = "chartHash"
    value = local.helm_chart_app_hash
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




  set {
    name  = "deployment.node.clusterName"
    value = aws_eks_cluster.eks_cluster.name
  }

  set {
    name  = "deployment.node.nodeGroupName"
    value = aws_eks_node_group.eks_node_group.node_group_name
  }

  set {
    name  = "deployment.node.vpcId"
    value = aws_vpc.vpc.id
  }

  set {
    name  = "deployment.node.databaseUrl"
    value = local.database_url
  }

  # client enviroenment variables
  set {
    name  = "deployment.client.viteExternalUrl"
    value = "http://${data.aws_lb.ingress_alb.dns_name}"
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
    value = "3"
  }

  set {
    name  = "hpa.targetCPUUtilizationPercentage"
    value = "80"
  }


  # set {
  #   name  = "hpa.targetMemoryUtilizationPercentage"
  #   value = "70"
  # }

  depends_on = [data.aws_lb.ingress_alb]
}
