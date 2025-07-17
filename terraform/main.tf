terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.44.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create VPC and subnets
module "vpc" {
  source     = "./modules/vpc"
  
  project_id = var.project_id
  region     = var.region
  vpc_name   = var.vpc_name
  environments = {
    for env, config in var.environments : env => {
      subnet_cidr  = config.subnet_cidr
      pod_cidr     = config.pod_cidr
      service_cidr = config.service_cidr
    }
  }
}

# Create GKE clusters
module "gke" {
  source       = "./modules/gke"
  
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  vpc_name     = module.vpc.vpc_name
  subnets      = module.vpc.subnets
  environments = {
    for env, config in var.environments : env => {
      node_count   = config.node_count
      machine_type = config.machine_type
    }
  }
  
  depends_on = [module.vpc]
}