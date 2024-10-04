# Linode Kubernetes Module

This Terraform module deploys a Kubernetes cluster on Linode along with supporting infrastructure including VPC, subnets, security groups, and a load balancer.

## Usage

```hcl
module "linode_kubernetes" {
  source  = "path/to/module"
  
  linode_token       = var.linode_token
  region             = "us-east"
  vpc_label          = "my-vpc"
  subnet_label       = "my-subnet"
  subnet_ipv4        = "10.0.0.0/24"
  internal_sg_label  = "internal-sg"
  external_sg_label  = "external-sg"
  cluster_label      = "my-cluster"
  kubernetes_version = "latest"
  node_pools         = [
    {
      type  = "g6-standard-2"
      count = 3
    }
  ]
  lb_label           = "my-loadbalancer"
  ssl_cert           = file("path/to/ssl/cert")
  ssl_key            = file("path/to/ssl/key")
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| linode_token | Your Linode API token | `string` | n/a | yes |
| region | The region where resources will be created | `string` | `"us-east"` | no |
| vpc_label | Label for the VPC | `string` | `"my-vpc"` | no |
| subnet_label | Label for the subnet | `string` | `"my-subnet"` | no |
| subnet_ipv4 | IPv4 range for the subnet | `string` | `"10.0.0.0/24"` | no |
| internal_sg_label | Label for the internal security group | `string` | `"internal-sg"` | no |
| external_sg_label | Label for the external security group | `string` | `"external-sg"` | no |
| cluster_label | Label for the Kubernetes cluster | `string` | `"my-cluster"` | no |
| kubernetes_version | Kubernetes version to use for the cluster | `string` | `"latest"` | no |
| node_pools | List of node pools to create | `list(object)` | `[{type = "g6-standard-2", count = 3}]` | no |
| lb_label | Label for the load balancer | `string` | `"my-loadbalancer"` | no |
| ssl_cert | SSL certificate for HTTPS configuration | `string` | `""` | no |
| ssl_key | SSL key for HTTPS configuration | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the created VPC |
| subnet_ids | The IDs of the created subnets |
| kubernetes_cluster_id | The ID of the created Kubernetes cluster |
| kubernetes_cluster_status | The status of the created Kubernetes cluster |
| kubernetes_api_endpoints | The API endpoints of the created Kubernetes cluster |
| load_balancer_ip | The IP address of the created load balancer |
| kubeconfig | Kubeconfig for the created cluster |

## Notes

- Ensure you have the Linode provider configured with your Linode API token.
- The module uses the latest available Kubernetes version by default. Specify a version if you need a specific one.
- SSL certificate and key are optional. If not provided, only HTTP configuration will be created for the load balancer.

