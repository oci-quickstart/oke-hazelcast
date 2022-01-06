resource "local_file" "kubeconfig" {
  #Adding this resource as a hack
  #There is no 'depends_on' argument in TF for providers
  #If this is not added, TF will destroy not work because resources won't be terminanted in appropriate order

  depends_on = [module.oke]
  filename   = "${path.module}/generated/lock"
}


provider "helm" {
  kubernetes {
    config_path = "${path.module}/generated/kubeconfig"
  }
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

data "local_file" "mancenter_info" {
    filename = "${path.module}/mancenter.txt"
    depends_on = [helm_release.my-release]
}

output "mancenter_info" {
  value = data.local_file.mancenter_info.content
}
