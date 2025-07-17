resource "google_container_cluster" "cluster" {
  for_each = var.environments
  
  name     = "${var.cluster_name}-${each.key}"
  location = var.region
  
  # Remove default node pool and create separately
  remove_default_node_pool = true
  initial_node_count       = 1
  
  # Networking
  network    = var.vpc_name
  subnetwork = var.subnets[each.key].name
  
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.vpc_name}-${each.key}-pods"
    services_secondary_range_name = "${var.vpc_name}-${each.key}-services"
  }
  
  # Security
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  for_each = var.environments
  
  name       = "${var.cluster_name}-${each.key}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.cluster[each.key].name
  node_count = each.value.node_count
  
  node_config {
    machine_type = each.value.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
    
    labels = {
      env = each.key
    }
    
    tags = ["gke-node", "${var.cluster_name}-${each.key}"]
  }
}