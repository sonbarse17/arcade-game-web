variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "arcade-game-vpc"
}

variable "cluster_name" {
  description = "Base name for the GKE clusters"
  type        = string
  default     = "arcade-game"
}

variable "environments" {
  description = "Configuration for each environment"
  type = map(object({
    node_count    = number
    machine_type  = string
    subnet_cidr   = string
    pod_cidr      = string
    service_cidr  = string
  }))
  default = {
    dev = {
      node_count    = 1
      machine_type  = "e2-medium"
      subnet_cidr   = "10.10.0.0/20"
      pod_cidr      = "10.20.0.0/16"
      service_cidr  = "10.30.0.0/16"
    },
    test = {
      node_count    = 2
      machine_type  = "e2-standard-2"
      subnet_cidr   = "10.11.0.0/20"
      pod_cidr      = "10.21.0.0/16"
      service_cidr  = "10.31.0.0/16"
    },
    prod = {
      node_count    = 3
      machine_type  = "e2-standard-4"
      subnet_cidr   = "10.12.0.0/20"
      pod_cidr      = "10.22.0.0/16"
      service_cidr  = "10.32.0.0/16"
    }
  }
}