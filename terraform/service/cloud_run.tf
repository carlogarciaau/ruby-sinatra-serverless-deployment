resource "google_cloud_run_service" "cloud_run_hello_world" {
  name     = local.service_name
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.hello_world_sa.email
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project}/${var.repository_id}/${local.service_name}"

        ports {
          name = "http1"
          container_port = 3000
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1000"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.run]
}

# Set service public
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.cloud_run_hello_world.location
  project  = google_cloud_run_service.cloud_run_hello_world.project
  service  = google_cloud_run_service.cloud_run_hello_world.name

  policy_data = data.google_iam_policy.noauth.policy_data
  depends_on  = [google_cloud_run_service.cloud_run_hello_world]
}