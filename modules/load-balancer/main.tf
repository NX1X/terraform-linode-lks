# load_balancer/main.tf

resource "linode_nodebalancer" "lb" {
  label  = var.lb_label
  region = var.region
  tags   = var.tags
}

resource "linode_nodebalancer_config" "http" {
  nodebalancer_id = linode_nodebalancer.lb.id
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

resource "linode_nodebalancer_config" "https" {
  nodebalancer_id = linode_nodebalancer.lb.id
  port            = 443
  protocol        = "https"
  check           = "connection"
  check_path      = "/"
  check_interval  = 30
  check_timeout   = 5
  check_attempts  = 3
  algorithm       = "roundrobin"
  stickiness      = "none"
  ssl_cert        = var.ssl_cert
  ssl_key         = var.ssl_key
}

# load_balancer/variables.tf

variable "lb_label" {
  description = "Label for the load balancer"
  type        = string
  default     = "my-load-balancer"
}

variable "region" {
  description = "The region where the load balancer will be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the load balancer"
  type        = list(string)
  default     = ["production"]
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

# load_balancer/outputs.tf

output "load_balancer_id" {
  description = "The ID of the created load balancer"
  value       = linode_nodebalancer.lb.id
}

output "load_balancer_ip" {
  description = "The IP address of the created load balancer"
  value       = linode_nodebalancer.lb.ipv4
}
