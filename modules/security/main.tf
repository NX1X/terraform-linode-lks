# security_groups/main.tf

resource "linode_firewall" "internal" {
  label = var.internal_sg_label
  tags  = var.tags

  inbound {
    label    = "allow-internal"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "1-65535"
    ipv4     = [var.vpc_ipv4_range]
    ipv6     = ["::/0"]
  }

  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"
}

resource "linode_firewall" "external" {
  label = var.external_sg_label
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
}

# security_groups/variables.tf

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

variable "tags" {
  description = "Tags to apply to security groups"
  type        = list(string)
  default     = ["production"]
}

variable "vpc_ipv4_range" {
  description = "IPv4 range of the VPC"
  type        = string
}

# security_groups/outputs.tf

output "internal_sg_id" {
  description = "The ID of the internal security group"
  value       = linode_firewall.internal.id
}

output "external_sg_id" {
  description = "The ID of the external security group"
  value       = linode_firewall.external.id
}
