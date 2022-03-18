
# Gets kubeconfig
data "oci_containerengine_cluster_kube_config" "oke" {
  cluster_id = module.oke.cluster_id
}

provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.cluster_ca_certificate
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", local.cluster_id, "--region", local.cluster_region]
      command     = "oci"
    }
  }
}

locals {
  cluster_endpoint       = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["clusters"][0]["cluster"]["server"]
  cluster_ca_certificate = base64decode(yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["clusters"][0]["cluster"]["certificate-authority-data"])
  cluster_id             = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["users"][0]["user"]["exec"]["args"][4]
  cluster_region         = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["users"][0]["user"]["exec"]["args"][6]
}

resource "helm_release" "my-release" {
  name       = "my-release"

  repository = "https://hazelcast-charts.s3.amazonaws.com/"
  chart      = "hazelcast"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  depends_on = [module.oke]

  provisioner "local-exec" {
    command = "export KUBECONFIG=./generated/kubeconfig && kubectl get svc --namespace default my-release-hazelcast-mancenter > mancenter.txt"
  }
}
