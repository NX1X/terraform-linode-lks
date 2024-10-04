# vpc/main.tf

resource "linode_vpc" "main" {
  label  = var.vpc_label
  region = var.region
}

resource "linode_vpc_subnet" "main" {
  vpc_id = linode_vpc.main.id
  label  = var.subnet_label
  ipv4   = var.subnet_ipv4
}

# vpc/variables.tf

variable "vpc_label" {
  description = "Label for the VPC"
  type        = string
  default     = "my-vpc"
}

variable "region" {
  description = "The region where the VPC will be created"
  type        = string
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

# vpc/outputs.tf

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = linode_vpc.main.id
}

output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = [linode_vpc_subnet.main.id]
}
