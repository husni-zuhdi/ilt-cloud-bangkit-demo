resource "google_compute_instance" "gce" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  tags = var.tags

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
    }
  }

  network_interface {
    network    = var.vpc_self_link
    subnetwork = var.subnet_self_link

    access_config {
      nat_ip       = var.ip_address
      network_tier = "PREMIUM"
    }
  }
  labels = {
    # Install Cloud Monitoring Agent
    "goog-ops-agent-policy" = "v2-x86-template-1-1-0"
    "container-vm"          = var.image_name
  }

  metadata = {
    "gce-container-declaration" = <<EOF
spec:
  containers:
  - image: "${var.service_image_uri}"
    name: "${var.service_name}"
  volumes: []
  restartPolicy: Always
EOF
  }

  service_account {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }
}
