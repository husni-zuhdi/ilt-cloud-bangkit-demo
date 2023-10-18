COMPUTE_URL_BASE = "https://www.googleapis.com/compute/v1/"


def GenerateConfig(context):
    """Creates the virtual machine with environment variables."""

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
                # Setup Compute Instance Tagging
                "tags": context.properties["tags"],
                # Setup OpsAgent to enalbe Google Cloud Operations Suite
                "metadata": {
                    "items": [
                        {
                            "key": "startup-script",
                            "value": "#! /bin/bash\ncurl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh\nsudo bash add-google-cloud-ops-agent-repo.sh --also-install",
                        }
                    ]
                },
            },
        }
    ]
    return {"resources": resources}
