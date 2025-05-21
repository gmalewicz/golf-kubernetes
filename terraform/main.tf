
data "digitalocean_kubernetes_versions" "kub_version" {
  version_prefix = "1.32."
}

resource "digitalocean_kubernetes_cluster" "golf-test" {
  name         = "golf-test"
  region       = var.do_region
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.kub_version.latest_version

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}

