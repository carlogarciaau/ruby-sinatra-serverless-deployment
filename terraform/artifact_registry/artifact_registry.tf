resource "google_artifact_registry_repository" "docker_repository" {
  provider = google-beta
  location = var.region
  repository_id = var.repository_id
  description = "Docker repository"
  format = "DOCKER"

  depends_on = [google_project_service.artifact_registry]
}

