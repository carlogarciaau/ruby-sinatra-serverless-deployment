# Summary
This repo deploys a Ruby Sinatra app to GCP Cloud Run. 

## Pre-requisites
+ A Google Cloud project with billing enabled
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

3. Provision a private docker registry. The makefile runs terraform `fmt -check` / `validate` / `plan` / `apply` for you. 
   ```
   cd artifact_registry
   make init
   make plan
   make apply
   ```

4. Build the Sinatra app and push to the docker repository. 
   ```
   cd app
   make build
   ```

5. Deploy the app to Cloud Run. The makefile runs terraform `fmt -check` / `validate` / `plan` / `apply` for you. 
   ```
   cd service
   make init
   make plan
   make apply
   ```
   + This will return a URL to access the deployed app

6. To cleanup the environment:
   + Run `make destroy` each under artifact_registry and service directories and repeat steps 1-5
