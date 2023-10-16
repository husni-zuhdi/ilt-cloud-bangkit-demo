# Setup Environment Variables
MACHINE_TYPE = 'f1-micro'
REGION = 'asia-southeast1'
ZONE = 'asia-southeast1-c'
DEPLOYMENT_NAME = 'ilt-5'
NETWORK_NAME = DEPLOYMENT_NAME + '-vpc'
SSH_FW_SOURCE_RANGES = ["36.72.213.213/32"]
SSH_FW_ALLOWED_RULES = [{'IPProtocol':'TCP', 'ports':['22']}]
SUBNET_IP_RANGE = "12.1.0.0/16"
SUBNET_NAME = DEPLOYMENT_NAME + REGION + '-subnet'

def GenerateConfig(unused_context):
  """Creates the Compute Engine with multiple templates."""

  resources = [{
      'name': NETWORK_NAME,
      'type': 'network-tpl.py'
  }, {
      'name': SUBNET_NAME,
      'type': 'subnet-tpl.py',
      'properties': {
          'network': NETWORK_NAME,
          'ipCidrRange': SUBNET_IP_RANGE,
          'region': REGION
        }
  }, {
      'name': NETWORK_NAME + '-ssh-firewall',
      'type': 'firewall-tpl.py',
      'properties': {
          'network': NETWORK_NAME,
          'sourceRanges': SSH_FW_SOURCE_RANGES,
          'allowed': SSH_FW_ALLOWED_RULES,
          'targetTags': ["ilt-5"]
      }
  }, {
      'name': DEPLOYMENT_NAME + '-virtual-machine',
      'type': 'compute-engine-tpl.py',
      'properties': {
          'machineType': MACHINE_TYPE,
          'zone': ZONE,
          'network': NETWORK_NAME,
          'subnetwork': SUBNET_NAME,
          'tags': {'items': [DEPLOYMENT_NAME]}
      }
  }]
  return {'resources': resources}
