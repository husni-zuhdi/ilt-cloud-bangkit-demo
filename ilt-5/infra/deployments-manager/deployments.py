# Setup Environment Variables
MACHINE_TYPE = "f1-micro"
REGION = "asia-southeast1"
ZONE = "asia-southeast1-c"
DEPLOYMENT_NAME = "ilt-5"
NETWORK_NAME = "-".join([DEPLOYMENT_NAME, "vpc"])
# Cloud IAP IP ranges for SSH
SSH_FW_SOURCE_RANGES = ["35.235.240.0/20"]
SSH_FW_ALLOWED_RULES = [{"IPProtocol": "TCP", "ports": ["22"]}]
HTTP_FW_SOURCE_RANGES = ["0.0.0.0/0"]
HTTP_FW_ALLOWED_RULES = [{"IPProtocol": "TCP", "ports": ["80"]}]
SUBNET_IP_RANGE = "12.1.0.0/16"
SUBNET_NAME = "-".join([NETWORK_NAME, REGION, "subnet"])
# Change SA_EMAIL with service account email from terraform output
SA_EMAIL = "custom-gce-ilt-5@husni-development.iam.gserviceaccount.com"


def GenerateConfig(unused_context):
    """
    Creates the Compute Engine with underlying Networking Infrastructure
    bellow included VPC Network, Subnetwork, and a SSH firewall.
    """

    resources = [
        # Create VPC Network
        {"name": NETWORK_NAME, "type": "network-tpl.py"},
        # Create Subnet inside VPC Network
        {
            "name": SUBNET_NAME,
            "type": "subnet-tpl.py",
            "properties": {
                "network": NETWORK_NAME,
                "ipCidrRange": SUBNET_IP_RANGE,
                "region": REGION,
            },
        },
        # Create SSH Firewall
        {
            "name": "-".join([DEPLOYMENT_NAME, "ssh-firewall"]),
            "type": "firewall-tpl.py",
            "properties": {
                "network": NETWORK_NAME,
                "sourceRanges": SSH_FW_SOURCE_RANGES,
                "allowed": SSH_FW_ALLOWED_RULES,
                "targetTags": [DEPLOYMENT_NAME],
            },
        },
        # Create HTTP Firewall
        {
            "name": "-".join([DEPLOYMENT_NAME, "http-firewall"]),
            "type": "firewall-tpl.py",
            "properties": {
                "network": NETWORK_NAME,
                "sourceRanges": HTTP_FW_SOURCE_RANGES,
                "allowed": HTTP_FW_ALLOWED_RULES,
                "targetTags": [DEPLOYMENT_NAME],
            },
        },
        # Create Google Compute Engine
        {
            "name": "-".join([DEPLOYMENT_NAME, "virtual-machine"]),
            "type": "compute-engine-tpl.py",
            "properties": {
                "machineType": MACHINE_TYPE,
                "zone": ZONE,
                "network": NETWORK_NAME,
                "subnetwork": SUBNET_NAME,
                "tags": {"items": [DEPLOYMENT_NAME]},
                "serviceAccounts": [{"email": SA_EMAIL, "scopes": ["https://www.googleapis.com/auth/cloud-platform"]}],
            },
        },
    ]
    return {"resources": resources}
