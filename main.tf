# main.tf

module "vpc" {
  source      = "./vpc"
  vpc_label   = var.vpc_label
  region      = var.region
  subnet_label = var.subnet_label
  subnet_ipv4 = var.subnet_ipv4
}

module "security_groups" {
  source         = "./security_groups"
  internal_sg_label = var.internal_sg_label
  external_sg_label = var.external_sg_label
  tags           = var.tags
  vpc_ipv4_range = var.subnet_ipv4
}

module "kubernetes" {
  source            = "./kubernetes"
  cluster_label     = var.cluster_label
  kubernetes_version = var.kubernetes_version
  region            = var.region
  tags              = var.tags
  node_pools        = var.node_pools
}

module "load_balancer" {
  source   = "./load_balancer"
  lb_label = var.lb_label
  region   = var.region
  tags     = var.tags
  ssl_cert = var.ssl_cert
  ssl_key  = var.ssl_key
}
