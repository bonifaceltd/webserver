resource "google_project_service" "api" {
  for_each = toset(["compute", "serviceusage", "iam", "iamcredentials", "cloudresourcemanager"])
  project  = var.project_id
  service  = "${each.value}.googleapis.com"

  disable_on_destroy = false
}