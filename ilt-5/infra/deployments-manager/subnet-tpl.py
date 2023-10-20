def GenerateConfig(context):
    """Creates subnetwork inside VPC Network."""

    resources = [
        {
            "name": context.env["name"],
            "type": "compute.v1.subnetwork",
            "properties": {
                "network": "$(ref." + context.properties["network"] + ".selfLink)",
                "ipCidrRange": context.properties["ipCidrRange"],
                "region": context.properties["region"],
            },
        }
    ]
    return {"resources": resources}
