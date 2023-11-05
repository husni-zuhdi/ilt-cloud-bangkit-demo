# ILT 6 Create Single Page Application and Protect it behind firewall

We'll create a single page application (SPA) with Golang and Vanila HTML+CSS.
Then deploy it to Compute Engine and protect it from public access with Firewall.

## Stacks

* Golang Programming Language v1.20
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

2. (⚠️  In Progress) Deploy docker image to Google Compute Engine

3. (⚠️  In Progress) Setup firewall to allow/block access to port 8080

## References
