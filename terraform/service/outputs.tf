output "service_url" {
  value = "${google_cloud_run_service.cloud_run_hello_world.status[0].url}/hello-world"
}