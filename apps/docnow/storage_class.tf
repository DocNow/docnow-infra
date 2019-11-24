resource "kubernetes_storage_class" "docnow_elastic_pvc" {
  metadata {
    name = "docnow-elastic-pvc"
  }

  storage_provisioner = "kubernetes.io/aws-ebs"

  reclaim_policy         = "Retain"
  allow_volume_expansion = true
  volume_binding_mode    = "Immediate"
}

