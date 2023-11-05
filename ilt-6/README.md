# ILT 6 Create Single Page Application and Protect it behind firewall

We'll create a single page application (spa) with Golang and HTMX.
Then deploy it to Compute Engine and protect it from public access with Firewall.

## Stacks

* Golang Programming Language v1.20
* [HTMX](https://htmx.org/)
* [migrate](https://github.com/golang-migrate/migrate)
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
3. Test the API with Browser
4. Teardown docker compose and delete image
   ```
   cd ilt-6/build/docker-compose
   docker compose down

   docker image rm <name_ilt e.g ilt6>:<ilt_version e.g 0.1.0>
   ```

## Production Step

## References
