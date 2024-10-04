# Data source to fetch available Kubernetes versions
data "linode_lke_versions" "available_versions" {}

# Create a Linode Kubernetes cluster
resource "linode_lke_cluster" "my_cluster" {
  label       = "nx1x-lab-dev"
  k8s_version = data.linode_lke_versions.available_versions.versions[0].id
  region      = var.region
  tags        = var.tags

  pool {
    type  = "g6-standard-2"
    count = 3
  }
}

# Create a NodeBalancer
resource "linode_nodebalancer" "my_nodebalancer" {
  label  = "nx1x-nodebalancer"
  region = var.region
  tags   = var.tags
}

# Create a NodeBalancer config
resource "linode_nodebalancer_config" "my_nodebalancer_config" {
  nodebalancer_id = linode_nodebalancer.my_nodebalancer.id
  port            = 80
  protocol        = "http"
  check           = "connection"
  check_path      = "/"
  check_interval  = 30
  check_timeout   = 5
  check_attempts  = 3
  algorithm       = "roundrobin"
  stickiness      = "none"
}

# Create a firewall
resource "linode_firewall" "my_firewall" {
  label = "nx1x-firewall"
  tags  = var.tags

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["0.0.0.0/0"]
    ipv6     = ["::/0"]
  }

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  linodes = flatten([
    for pool in linode_lke_cluster.my_cluster.pool : [
      for node in pool.nodes : node.instance_id
    ]
  ])
}