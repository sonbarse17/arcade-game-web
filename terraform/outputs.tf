output "vpc_name" {
  description = "The name of the VPC"
  value       = module.vpc.vpc_name
}

output "cluster_endpoints" {
  description = "The IP addresses of the GKE clusters"
  value       = module.gke.cluster_endpoints
}

output "cluster_names" {
  description = "The names of the GKE clusters"
  value       = module.gke.cluster_names
}

output "kubeconfig_commands" {
  description = "Commands to configure kubectl for each cluster"
  value = {
    for env, endpoint in module.gke.cluster_endpoints :
    env => "gcloud container clusters get-credentials ${module.gke.cluster_names[env]} --region ${var.region} --project ${var.project_id}"
  }
}