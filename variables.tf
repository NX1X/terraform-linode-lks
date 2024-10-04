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

variable "vpc_label" {
  description = "Label for the VPC"
  type        = string
  default     = "my-vpc"
}

variable "subnet_label" {
  description = "Label for the subnet"
  type        = string
  default     = "my-subnet"
}

variable "subnet_ipv4" {
  description = "IPv4 range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "internal_sg_label" {
  description = "Label for the internal security group"
  type        = string
  default     = "internal-sg"
}

variable "external_sg_label" {
  description = "Label for the external security group"
  type        = string
  default     = "external-sg"
}

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

variable "lb_label" {
  description = "Label for the load balancer"
  type        = string
  default     = "my-loadbalancer"
}

variable "ssl_cert" {
  description = "SSL certificate for HTTPS configuration"
  type        = string
  default     = ""
}

variable "ssl_key" {
  description = "SSL key for HTTPS configuration"
  type        = string
  default     = ""
}
