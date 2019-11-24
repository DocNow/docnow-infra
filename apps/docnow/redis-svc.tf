resource "kubernetes_service" "redis_master" {
  metadata {
    name = "redis-master"

    labels = {
      app = "redis"

      role = "master"

      tier = "backend"
    }
  }

  spec {
    port {
      port        = 6379
      target_port = "6379"
    }

    selector = {
      app = "redis"

      role = "master"

      tier = "backend"
    }
  }
}

