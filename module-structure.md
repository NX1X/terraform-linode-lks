# Module Structure
.
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── vpc.tf
├── security_groups.tf
├── kubernetes.tf
├── load_balancer.tf
└── README.md

# main.tf
# This file will be the entry point of your module

# Import other module components
module "vpc" {
  source = "./vpc"
  # Pass necessary variables
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
  # Pass other necessary variables
}

module "kubernetes" {
  source = "./kubernetes"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  security_group_ids = [
    module.security_groups.internal_sg_id,
    module.security_groups.external_sg_id
  ]
  # Pass other necessary variables
}

module "load_balancer" {
  source = "./load_balancer"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  security_group_id = module.security_groups.external_sg_id
  # Pass other necessary variables
}

# versions.tf
terraform {
  required_version = ">= 0.13.0"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
}

# variables.tf
variable "linode_token" {
  description = "Your Linode API token"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-east"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = ["production"]
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the cluster"
  type        = string
  default     = "latest"
}

variable "node_pool_type" {
  description = "The type of nodes to use in the node pool"
  type        = string
  default     = "g6-standard-2"
}

variable "node_pool_count" {
  description = "The number of nodes in the node pool"
  type        = number
  default     = 3
}

# Add more variables as needed for VPC, subnets, etc.

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
