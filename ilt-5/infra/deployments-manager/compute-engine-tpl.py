COMPUTE_URL_BASE = "https://www.googleapis.com/compute/v1/"
STARUTP_SCRIPT = """
#! /bin/bash
echo "Install OpsAgent"
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

echo "Install Docker"
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Setup docker access token"
gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin https://gcr.io

echo "Sleep for 30 seconds"
sleep 30s

echo "Pull desired image"
sudo docker pull gcr.io/husni-development/ilt-4:0.1.0
"""


def GenerateConfig(context):
    """Creates the virtual machine."""

    resources = [
        {
            "name": context.env["name"],
            "type": "compute.v1.instance",
            "properties": {
                "zone": context.properties["zone"],
                "machineType": "".join(
                    [
                        COMPUTE_URL_BASE,
                        "projects/",
                        context.env["project"],
                        "/zones/",
                        context.properties["zone"],
                        "/machineTypes/",
                        context.properties["machineType"],
                    ]
                ),
                "disks": [
                    {
                        "deviceName": "boot",
                        "type": "PERSISTENT",
                        "boot": True,
                        "autoDelete": True,
                        "initializeParams": {
                            # Setup Source Image
                            "sourceImage": "".join(
                                [
                                    COMPUTE_URL_BASE,
                                    "projects/",
                                    "debian-cloud/global/",
                                    "images/family/debian-11",
                                ]
                            )
                        },
                    }
                ],
                "networkInterfaces": [
                    {
                        # Setup VPC Network
                        "network": "$(ref."
                        + context.properties["network"]
                        + ".selfLink)",
                        # Setup Subnetwork
                        "subnetwork": "$(ref."
                        + context.properties["subnetwork"]
                        + ".selfLink)",
                        "accessConfigs": [
                            {"name": "External NAT", "type": "ONE_TO_ONE_NAT"}
                        ],
                    }
                ],
                "serviceAccounts": context.properties["serviceAccounts"],
                # Setup Compute Instance Tagging
                "tags": context.properties["tags"],
                # Setup Labeling for OpsAgent
                "labels": {"goog-ops-agent-policy": "v2-x86-template-1-1-0"},
                # Setup Metadata
                # Setup OpsAgent to enalbe Google Cloud Operations Suite
                # Setup Docker for Compute Engine
                "metadata": {
                    "items": [
                        {
                            "key": "startup-script",
                            "value": STARUTP_SCRIPT,
                        }
                    ]
                },
            },
        }
    ]
    return {"resources": resources}
