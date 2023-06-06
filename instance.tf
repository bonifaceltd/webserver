resource "google_compute_instance" "webserver" {
  project      = var.project_id
  name         = "webserver"
  machine_type = "n1-standard-1"
  zone         = var.zone

  tags = ["allow-https", "allow-ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    subnetwork = module.vpc.subnets["${var.region}/webserver"].self_link
    access_config {}
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = file("${path.module}/startup.sh")
}