FROM continuumio/miniconda3:23.5.2-0

# Allow statements and log messages to immediately appear in the Knative logs
# ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /api
WORKDIR $APP_HOME
COPY . ./

# Install apt level dependencies
RUN apt-get update && apt-get install -y \
    python3-tk \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install latest taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /bin

# Setup Conda Environment
RUN task conda-create
SHELL ["conda", "run", "-n", "api", "/bin/bash", "-c"]

# Install conda and pip packages
RUN task conda-install
RUN task pip-install

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
# Timeout is set to 0 to disable the timeouts of the workers to allow Cloud Run to handle instance scaling.
EXPOSE 8081
# CMD exec gunicorn --bind :8081 --workers 1 --threads 8 --timeout 0 main:app
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "api", "exec", "gunicorn", "--bind", ":8081", "--workers", "1", "--threads", "8", "--timeout", "0", "main:app"]
# CMD exec sleep 3600
