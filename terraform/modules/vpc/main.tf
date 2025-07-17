resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = var.environments
  
  name          = "${var.vpc_name}-${each.key}-subnet"
  ip_cidr_range = each.value.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  
  secondary_ip_range {
    range_name    = "${var.vpc_name}-${each.key}-pods"
    ip_cidr_range = each.value.pod_cidr
  }
  
  secondary_ip_range {
    range_name    = "${var.vpc_name}-${each.key}-services"
    ip_cidr_range = each.value.service_cidr
  }
}