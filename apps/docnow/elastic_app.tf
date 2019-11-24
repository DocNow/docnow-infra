resource "kubernetes_stateful_set" "es_cluster" {
  metadata {
    name = "es-cluster"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "elasticsearch"
      }
    }

    template {
      metadata {
        labels = {
          app = "elasticsearch"
        }
      }

      spec {
        init_container {
          name    = "fix-permissions"
          image   = "busybox"
          command = ["sh", "-c", "chown -R 1000:1000 /usr/share/elasticsearch/data"]

          volume_mount {
            name       = "data"
            mount_path = "/usr/share/elasticsearch/data"
          }

          security_context {
            privileged = true
          }
        }

        init_container {
          name    = "increase-vm-max-map"
          image   = "busybox"
          command = ["sysctl", "-w", "vm.max_map_count=262144"]

          security_context {
            privileged = true
          }
        }

        init_container {
          name    = "increase-fd-ulimit"
          image   = "busybox"
          command = ["sh", "-c", "ulimit -n 65536"]

          security_context {
            privileged = true
          }
        }

        container {
          name  = "elasticsearch"
          image = "docker.elastic.co/elasticsearch/elasticsearch-oss:6.4.3"

          port {
            name           = "rest"
            container_port = 9200
            protocol       = "TCP"
          }

          port {
            name           = "inter-node"
            container_port = 9300
            protocol       = "TCP"
          }

          env {
            name  = "cluster.name"
            value = "docnow-elastic-demo"
          }

          env {
            name = "node.name"

            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name  = "discovery.zen.ping.unicast.hosts"
            value = "es-cluster-0.elasticsearch,es-cluster-1.elasticsearch,es-cluster-2.elasticsearch"
          }

          env {
            name  = "discovery.zen.minimum_master_nodes"
            value = "2"
          }

          env {
            name  = "ES_JAVA_OPTS"
            value = "-Xms512m -Xmx512m"
          }

          resources {
            limits {
              cpu = "1"
            }

            requests {
              cpu = "100m"
            }
          }

          volume_mount {
            name       = "data"
            mount_path = "/usr/share/elasticsearch/data"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "data"

        labels = {
          app = "elasticsearch"
        }
      }

      spec {
        access_modes = ["ReadWriteOnce"]

        resources {
          requests = {
            storage = "10Gi"
          }
        }

        storage_class_name = "docnow-elastic-pvc"
      }
    }

    service_name = "elasticsearch"
  }
}

