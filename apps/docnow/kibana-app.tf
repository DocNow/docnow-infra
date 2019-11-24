resource "kubernetes_deployment" "kibana" {
  metadata {
    name = "kibana"

    labels = {
      app = "kibana"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "kibana"
      }
    }

    template {
      metadata {
        labels = {
          app = "kibana"
        }
      }

      spec {
        container {
          name  = "kibana"
          image = "docker.elastic.co/kibana/kibana-oss:6.4.3"

          port {
            container_port = 5601
          }

          env {
            name  = "ELASTICSEARCH_URL"
            value = "http://elasticsearch:9200"
          }

          resources {
            limits {
              cpu = "1"
            }

            requests {
              cpu = "100m"
            }
          }
        }
      }
    }
  }
}

