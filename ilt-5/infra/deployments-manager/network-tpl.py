def GenerateConfig(context):
    """Creates a VPC network."""

    resources = [
        {
            "name": context.env["name"],
            "type": "compute.v1.network",
            "properties": {
                "routingConfig": {"routingMode": "REGIONAL"},
                "autoCreateSubnetworks": False,
            },
        }
    ]
    return {"resources": resources}
