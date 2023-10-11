# ILT 4 Demo: Golang Backend with Cloud Run and Cloud SQL

We'll create a simple backend service that stores user data in an SQL database. We'll use CloudSQL-managed service solution from the Google Cloud Platform

## Stacks

* Golang Programming Language v1.19
* [Echo Framework](https://github.com/labstack/echo)
* [sqlc](https://github.com/sqlc-dev/sqlc)
* [migrate](https://github.com/golang-migrate/migrate)
* [terraform](terraform.io/)
* [docker (compose)](https://www.docker.com/)

## Development Step

1. Create `.env` file and export it as environment variables
   ```
   cd ilt-4
   cat << EOT > .env
   DB_USER="<your_db_username>"
   DB_PASSWORD="<your_db_password>"
   DB_HOST="localhost" #For development
   DB_HOST_COMPOSE="db" #For development on docker compose
   DB_PORT="5432"
   DB_NAME="<your_db_name>"
   POSTGRESQL_URL="postgres://<your_db_username>:<your_db_password>@<your_db_host>:5432/<your_db_name>?sslmode=disable"
   EOT
   export $(xargs < .env)
   ```
2. Build a Docker image with this command
   ```
   cd ilt-4
   docker build -t <name_ilt e.g ilt4>:<ilt_version e.g 0.1.0> -f ./Dockerfile.prod .
   ```
3. Run docker compose in `./build/docker-compose/` folder
   ```
   cd ilt-4/build/docker-compose
   docker compose up -d
   ```
4. Migrate database schema
   ```
   cd ilt-4
   migrate -database $POSTGRESQL_URL -path migrations/migrate up
   ```
6. Test the API with Postman
7. Teardown docker compose and delete image
   ```
   cd ilt-4/build/docker-compose
   docker compose down

   docker image rm <name_ilt e.g ilt4>:<ilt_version e.g 0.1.0>
   ```

## Production Step

1. Push docker image from Development Step # 2 to Google Container Registry
   ```
   docker tag <name_ilt e.g ilt4>:<ilt_version e.g 0.1.0> gcr.io/<your_project_id>/<name_ilt e.g ilt4>:<ilt_version e.g 0.1.0>
   docker push gcr.io/<your_project_id>/<name_ilt e.g ilt4>:<ilt_version e.g 0.1.0>
   ```
2. Upload the migration schema that is located on `ilt-4/migrations/migrate/*.up.sql` to any Google Cloud Storage bucket
3. Update your `.env` file from Development Step # 1 with new envars
   ```
   cd ilt-4
   cat << EOT >> .env
   PROJECT_ID="<your_gcp_project_id>"
   REGION="<your_prefered_region>"
   ILT_NAME="ilt-4"
   CLOUDSQL_NAME_PREFIX="<you_prefered_prefix>"
   SUBNET_IP_RANGE="11.1.0.0/16"
   EOT
   export $(xargs < .env)
   ```
4. Prepare the terraform envars
   ```
   export GCR_VERSION="$(git describe --tags --abbrev=0 | cut -d '/' -f2)"
   export TF_VAR_project="$PROJECT_ID"
   export TF_VAR_region="$REGION"
   export TF_VAR_ilt_name="$ILT_NAME"
   export TF_VAR_image="gcr.io/$PROJECT_ID/$ILT_NAME:$GCR_VERSION"
   export TF_VAR_db_user="$DB_USER"
   export TF_VAR_db_password="$DB_PASSWORD"
   export TF_VAR_db_port="$DB_PORT"
   export TF_VAR_db_name="$DB_NAME"
   export TF_VAR_name_prefix="$CLOUDSQL_NAME_PREFIX"
   export TF_VAR_master_user_name="$DB_USER"
   export TF_VAR_master_user_password="$DB_PASSWORD"
   export TF_VAR_subnet_ip_range="$SUBNET_IP_RANGE"
   export TF_VAR_subnet_region="$REGION"
   ```
5. Got to `infra/ilt-4/gcp-vpc` to create a new VPC network with a subnet, private service connection, and serverless VPC access
   ```
   terraform apply # Then type yes
   ```
6. Got to `infra/ilt-4/gcp-cloud-sql` to create a new CloudSQL instance
   ```
   terraform apply # Then type yes
   ```
7. After CloudSQL was created. Go to GCP Console > Cloud SQL > your_instance
8. Click Import in the top ribbon. Select the migration schema that you uploaded to Google Cloud Storage. Select the `users` database. Then start the migration by clicking `Import`
9. Got to `infra/ilt-4/gcp-cloud-run` to create a new Cloud Run container
   ```
   terraform apply # Then type yes
   ```
10. In the terraform output there will be a variable service_url that contains your API URL. You can test your API with it

## References

* [Creating an API using Go and sqlc](https://eltonminetto.dev/en/post/2022-10-22-creating-api-using-go-sqlc/)
* [Automating Docker Image Push to Google Container Registry (GCR) and GitHub Packages / GitHub Container Registry (GHCR) using GitHub Action Pipeline](https://medium.com/@ardhanyoga/automating-docker-image-push-to-github-packages-github-container-registry-ghcr-and-google-3ffea20f595b)
* [PostgreSQL Cloud SQL Private IP Example](https://github.com/gruntwork-io/terraform-google-sql/blob/master/examples/postgres-private-ip/README.md)
* [Build your Go image](https://docs.docker.com/language/golang/build-images/#overview)
