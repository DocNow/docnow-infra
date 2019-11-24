resource "kubernetes_deployment" "redis_master" {
  metadata {
    name = "redis-master"

    labels = {
      app = "redis"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"

        role = "master"

        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"

          role = "master"

          tier = "backend"
        }
      }

      spec {
        container {
          name  = "master"
          image = "redis"

          port {
            container_port = 6379
          }

          resources {
            requests {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

