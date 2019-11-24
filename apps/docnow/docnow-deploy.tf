resource "kubernetes_deployment" "docnow_app_poc" {
  metadata {
    name = "docnow-app-poc"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "docnow-app-poc"
      }
    }

    template {
      metadata {
        labels = {
          app = "docnow-app-poc"
        }
      }

      spec {
        container {
          name  = "docnow-app-poc"
          image = "docnow/docnow:latest"

          port {
            container_port = 3000
          }

          env {
            name  = "REDIS_HOST"
            value = "redis-master"
          }

          env {
            name  = "REDIS_PORT"
            value = "6379"
          }

          env {
            name  = "ES_HOST"
            value = "elasticsearch:9200"
          }

          resources {
            requests {
              memory = "100Mi"
              cpu    = "100m"
            }
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}

