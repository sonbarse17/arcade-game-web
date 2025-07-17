variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "arcade-game-vpc"
}

variable "environments" {
  description = "Configuration for each environment's networking"
  type = map(object({
    subnet_cidr  = string
    pod_cidr     = string
    service_cidr = string
  }))
}