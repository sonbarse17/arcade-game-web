output "cluster_endpoints" {
  description = "The IP addresses of the GKE clusters"
  value = {
    for env, cluster in google_container_cluster.cluster : 
    env => cluster.endpoint
  }
}

output "cluster_names" {
  description = "The names of the GKE clusters"
  value = {
    for env, cluster in google_container_cluster.cluster : 
    env => cluster.name
  }
}

output "cluster_ca_certificates" {
  description = "The CA certificates of the GKE clusters"
  value = {
    for env, cluster in google_container_cluster.cluster : 
    env => cluster.master_auth.0.cluster_ca_certificate
  }
  sensitive = true
}