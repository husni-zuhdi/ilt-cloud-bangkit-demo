# ILT 5 Create simple webserver and break it!

We'll create a simple webserver and deploy it to Compute Engine with Cloud Deployment Manager.

Then we'll test it with Postman and will monitor our application from Monitoring and check the logs with Logging.

## Stacks

* Golang Programming Language v1.19
* [Echo Framework](https://github.com/labstack/echo)
* [docker (compose)](https://www.docker.com/)

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
1. Go to `ilt-5/infra/deployment-manager` and deploy our application and infra with Cloud Deployment Manager
   ```
   gcloud deployment-manager deployments create deployments --config deployments.yaml
   ```
