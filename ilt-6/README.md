# ILT 6 Create Single Page Application and Protect it behind firewall

We'll create a single page application (SPA) with Golang and Vanila HTML+CSS.
Then deploy it to Compute Engine and protect it from public access with Firewall.

## Stacks

* Golang Programming Language v1.20
* [terraform](terraform.io/)
* [docker (compose)](https://www.docker.com/)

## Development Step

1. Build a Docker image with this command
   ```
   cd ilt-6
   docker build -t <name_ilt e.g ilt6>:<ilt_version e.g 0.1.0> -f ./Dockerfile.prod .
   ```
2. Run docker compose in `./build/docker-compose/` folder
   ```
   cd ilt-6/build/docker-compose
   docker compose up -d
   ```
3. Test website with Browser
4. Teardown docker compose and delete image
   ```
   cd ilt-6/build/docker-compose
   docker compose down

   docker image rm <name_ilt e.g ilt6>:<ilt_version e.g 0.1.0>
   ```

## Production Step

1. Push docker image from Development Step # 1 to Google Container Registry
   ```
   docker tag <name_ilt e.g ilt6>:<ilt_version e.g 0.1.0> gcr.io/<your_project_id>/<name_ilt e.g ilt6>:<ilt_version e.g 0.1.0>
   docker push gcr.io/<your_project_id>/<name_ilt e.g ilt6>:<ilt_version e.g 0.1.0>

2. Create `.env` file to setup environment variables
   ```
   cd ilt-6
   cat << EOT >> .env
   ILT_NAME="ilt-6"
   PROJECT_ID="<your_gcp_project_id>"
   REGION="<your_prefered_region | default = asia-southeast1>"
   MACHINE_TYPE=<your_prefered_machine_type | default = f1-micro>
   SUBNET_IP_RANGE="<your_prefered_ip_range | default = 12.0.0.0/16>"
   EOT
   export $(xargs < .env)
   ```

3. Prepare the terraform envars
   ```
   export GCR_VERSION="$(git describe --tags --abbrev=0 | cut -d '/' -f2)"
   export TF_VAR_project_id="$PROJECT_ID"
   export TF_VAR_region="$REGION"
   export TF_VAR_ilt_name="$ILT_NAME"
   export TF_VAR_image="gcr.io/$PROJECT_ID/$ILT_NAME:$GCR_VERSION"
   export TF_VAR_subnet_ip_range="$SUBNET_IP_RANGE"
   export TF_VAR_subnet_region="$REGION"
   export TF_VAR_machine_type="$MACHINE_TYPE"
   ```

4. Init and apply terraform folder inside `ilt-6/infra` folder in this order
   ```
   # Order
   # gcp-vpc
   # gcp-ip-address
   # gcp-service-account
   # gcp-compute-engine
   # gcp-firewall/allow-custom-http-from-public
   # (Debug) gcp-firewall/allow-ssh-from-iap

   # Execute Init
   terraform init
   # Apply
   terraform apply # Type yes to apply
   ```

5. After finished, delete all resources
   ```
   # Order
   # (Debug) gcp-firewall/allow-ssh-from-iap
   # gcp-firewall/allow-custom-http-from-public
   # gcp-compute-engine
   # gcp-service-account
   # gcp-ip-address
   # gcp-vpc

   # Execute Destroy
   terraform destroy # Type yes to destroy
   ```
## References
