# outputs.tf

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = module.vpc.subnet_ids
}

output "kubernetes_cluster_id" {
  description = "The ID of the created Kubernetes cluster"
  value       = module.kubernetes.cluster_id
}

output "kubernetes_cluster_status" {
  description = "The status of the created Kubernetes cluster"
  value       = module.kubernetes.cluster_status
}

output "kubernetes_api_endpoints" {
  description = "The API endpoints of the created Kubernetes cluster"
  value       = module.kubernetes.api_endpoints
}

output "load_balancer_ip" {
  description = "The IP address of the created load balancer"
  value       = module.load_balancer.load_balancer_ip
}

output "kubeconfig" {
  description = "Kubeconfig for the created cluster"
  value       = module.kubernetes.kubeconfig
  sensitive   = true
}
