variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the cluster"
  type        = string
}

variable "cluster_name" {
  description = "Base name for the GKE clusters"
  type        = string
  default     = "arcade-game"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets" {
  description = "The subnet resources created by the VPC module"
  type        = map(any)
}

variable "environments" {
  description = "Configuration for each environment"
  type = map(object({
    node_count   = number
    machine_type = string
  }))
}