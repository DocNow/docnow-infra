resource "kubernetes_service" "elasticsearch" {
  metadata {
    name = "elasticsearch"

    labels = {
      app = "elasticsearch"
    }
  }

  spec {
    port {
      name = "rest"
      port = 9200
    }

    port {
      name = "inter-node"
      port = 9300
    }

    selector = {
      app = "elasticsearch"
    }

    cluster_ip = "None"
  }
}

