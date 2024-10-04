# kubernetes/main.tf

data "linode_lke_versions" "available_versions" {}

resource "linode_lke_cluster" "cluster" {
  label       = var.cluster_label
  k8s_version = var.kubernetes_version == "latest" ? data.linode_lke_versions.available_versions.versions[0].id : var.kubernetes_version
  region      = var.region
  tags        = var.tags

  dynamic "pool" {
    for_each = var.node_pools
    content {
      type  = pool.value.type
      count = pool.value.count
    }
  }
}

# kubernetes/variables.tf

variable "cluster_label" {
  description = "Label for the Kubernetes cluster"
  type        = string
  default     = "my-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the cluster"
  type        = string
  default     = "latest"
}

variable "region" {
  description = "The region where the cluster will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the cluster"
  type        = list(string)
  default     = ["production"]
}

variable "node_pools" {
  description = "List of node pools to create"
  type = list(object({
    type  = string
    count = number
  }))
  default = [
    {
      type  = "g6-standard-2"
      count = 3
    }
  ]
}

# kubernetes/outputs.tf

output "cluster_id" {
  description = "The ID of the created Kubernetes cluster"
  value       = linode_lke_cluster.cluster.id
}

output "cluster_status" {
  description = "The status of the created Kubernetes cluster"
  value       = linode_lke_cluster.cluster.status
}

output "api_endpoints" {
  description = "The API endpoints of the created Kubernetes cluster"
  value       = linode_lke_cluster.cluster.api_endpoints
}

output "kubeconfig" {
  description = "Kubeconfig for the created cluster"
  value       = linode_lke_cluster.cluster.kubeconfig
  sensitive   = true
}
