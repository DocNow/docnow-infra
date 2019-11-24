resource "kubernetes_service" "docnow_app_poc" {
  metadata {
    name = "docnow-app-poc"
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = "3000"
    }

    selector = {
      app = "docnow-app-poc"
    }

    type = "LoadBalancer"
  }
  depends_on = [module.eks.cluster_id]
}

output "lb_ip" {
  value = kubernetes_service.docnow_app_poc.load_balancer_ingress[0].ip
}

output "lb_name" {
  value = kubernetes_service.docnow_app_poc.load_balancer_ingress[0].hostname
}
