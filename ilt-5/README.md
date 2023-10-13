# ILT 5 Demo:  Create simple webserver and break it!

We'll create a simple webserver and deploy it to Cloud Run with Cloud Deployment Manager.

Then we'll test it with Postman and will monitor our application from Monitoring and check the logs with Logging.

## Stacks

* Golang Programming Language v1.19
* [Echo Framework](https://github.com/labstack/echo)
* [docker (compose)](https://www.docker.com/)

## Development Step

1. In Progress

## Production Step

1. Go to `ilt-5/infra` and deploy our application and infra with Cloud Deployment Manager
  ```
  gcloud deployment-manager deployments create deployments --config deployments.yaml
  ```
