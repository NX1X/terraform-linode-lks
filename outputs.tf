output "kubeconfig" {
  value     = linode_lke_cluster.my_cluster.kubeconfig
  sensitive = true
}

output "nodebalancer_ip" {
  value = linode_nodebalancer.my_nodebalancer.ipv4
}

output "cluster_id" {
  value       = linode_lke_cluster.my_cluster.id
  description = "The ID of the LKE cluster"
}

output "cluster_status" {
  value       = linode_lke_cluster.my_cluster.status
  description = "The status of the LKE cluster"
}

output "cluster_api_endpoints" {
  value       = linode_lke_cluster.my_cluster.api_endpoints
  description = "The API endpoints of the LKE cluster"
}

output "node_pools" {
  value       = linode_lke_cluster.my_cluster.pool
  description = "Information about the node pools in the LKE cluster"
  sensitive   = true
}