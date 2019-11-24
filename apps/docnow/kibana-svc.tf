resource "kubernetes_service" "kibana" {
  metadata {
    name = "kibana"

    labels = {
      app = "kibana"
    }
  }

  spec {
    port {
      port = 5601
    }

    selector = {
      app = "kibana"
    }
  }
}

