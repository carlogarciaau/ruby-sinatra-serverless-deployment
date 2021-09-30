# Summary
This repo deploys a Ruby Sinatra app to GCP Cloud Run. 

## Pre-requisites
+ A Google Cloud project with [billing enabled]
+ Download Terraform cli (tested with v1.0.7 as of this writing)
+ Download and setup gcloud cli tool
  - gcloud init
  - gcloud auth application-default login
  - gcloud auth configure-docker <gcp_region>-docker.pkg.dev

## Deployment Instructions
1. Configure variables in terraform/common.tfvars
   - project = your GCP project ID
   - region = GCP region
   - repository_id = desired name for your docker repository

2. Configure app/cloudbuild.yaml variables for region and repository_id

3. Provision a private docker registry
   ```
   cd artifact_registry
   terraform init
   make apply
   ```

4. Build the Sinatra app and push to the docker repository. 
   ```
   cd app
   make build
   ```

5. Deploy the app to Cloud Run
   ```
   cd service
   terraform init
   make apply
   ```
   + This will return a URL to access the deployed app

6. To cleanup the environment:
   + Run `make destroy` each under artifact_registry and service directories and repeat steps 1-5

## Approach, Considerations and Assumptions
1. I chose Cloud Run as the simplest, cost-efficient, serverless solution to deploy the app in a scalable and highly available manner.
2. Assumed that the app would be publicly accessible and had no dependencies
3. For security, ensured that the container didn't run as root and created a non-default service account with minimal permissions to assign as the service's identity
4. Other options:
   - Add an HTTPS load balancer for requirements like CDN, domain mapping and multi-region deployment
   - Provision a K8s cluster for more complex workloads like microservices

## Further Improvements
1. CI/CD pipeline for the app, and potentially include the cloud run deployment step in the automation pipeline
2. Blue/green and canary releases
3. Monitoring/alerting 

## My live endpoint currently at https://hello-world-atp4hhew6a-ts.a.run.app/hello-world