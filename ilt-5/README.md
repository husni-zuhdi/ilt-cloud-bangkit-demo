# ILT 5 Create Vritual Machine with Google Deployment Manager

We'll create a simple webserver and deploy it to Compute Engine with Cloud Deployment Manager.

## Stacks

* Google Deployment Manager
* Terrafrorm

## Development Step

1. In Progress

## Production Step

1. Setup .`env` file for envars

   ```
   cd ilt-5
   cat << EOT >> .env
   PROJECT_ID="<your_gcp_project_id>"
   ILT_NAME="ilt-5"
   SA_NAME="custom-gce"
   SA_DISPLAY_NAME="Custom GCE"
   EOT
   export $(xargs < .env)
   ```
2. Prepare the terraform envars
   ```
   export TF_VAR_project="$PROJECT_ID"
   export TF_VAR_ilt_name="$ILT_NAME"
   export TF_VAR_sa_name="$SA_NAME"
   export TF_VAR_sa_display_name="$SA_DISPLAY_NAME"
   ```
3. Go to `ilt-5/infra/deployment-manager` and deploy our application and infra with Cloud Deployment Manager
   ```
   gcloud deployment-manager deployments create deployments --config deployments.yaml
   ```

## References
* [Deployment Manager Example by steps](https://github.com/GoogleCloudPlatform/deploymentmanager-samples/tree/59f289993c8078aced16a177f3c0efe9a7efa736/examples/v2/step_by_step_guide)
* [Deployment Manager supported resources list](https://cloud.google.com/deployment-manager/docs/configuration/supported-resource-types#apis_for_supported_resources)
