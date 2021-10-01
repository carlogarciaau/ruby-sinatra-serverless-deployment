provider "google" {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

locals {
  service_name = "hello-world"
}

# Enable Cloud Run service
resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

# Create a service account
resource "google_service_account" "hello_world_sa" {
  account_id   = "hello-world"
  display_name = "Hello World! SA"
}

# Set permissions
resource "google_project_iam_binding" "service_permissions" {
  for_each = toset([
    "run.invoker", "cloudfunctions.invoker"
  ])

  role = "roles/${each.key}"
  members = [
    "serviceAccount:${google_service_account.hello_world_sa.email}",
  ]
  depends_on = [google_service_account.hello_world_sa]
}
