# ILT 4 Demo: Golang Backend with Cloud Run and Cloud SQL

We'll create a simple backend service that store user data in SQL database. We'll use CloudSQL managed service solution from Google Cloud Platform

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

1. In Progress

## References

* [Creating an API using Go and sqlc](https://eltonminetto.dev/en/post/2022-10-22-creating-api-using-go-sqlc/)
* [Automating Docker Image Push to Google Container Registry (GCR) and GitHub Packages / GitHub Container Registry (GHCR) using GitHub Action Pipeline](https://medium.com/@ardhanyoga/automating-docker-image-push-to-github-packages-github-container-registry-ghcr-and-google-3ffea20f595b)
* [PostgreSQL Cloud SQL Private IP Example](https://github.com/gruntwork-io/terraform-google-sql/blob/master/examples/postgres-private-ip/README.md)
* [Build your Go image](https://docs.docker.com/language/golang/build-images/#overview)
