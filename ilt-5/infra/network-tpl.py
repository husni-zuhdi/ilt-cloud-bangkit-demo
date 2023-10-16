def GenerateConfig(context):
  """Creates the network with environment variables."""

  resources = [{
      'name': context.env['name'],
      'type': 'compute.v1.network',
      'properties': {
          'routingConfig': {
              'routingMode': 'REGIONAL'
          },
          'autoCreateSubnetworks': False
      }
  }]
  return {'resources': resources}
