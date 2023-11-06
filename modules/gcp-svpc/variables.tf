variable "project" {
  description = "The project ID to where VPC will created."
  type        = string
}

variable "region" {
  description = "Region of resource."
  type        = string
}

variable "vpc_network_id" {
  description = "The ID of VPC."
  type        = string
}

variable "vpc_network_self_link" {
  description = "The Self Link URI of VPC."
  type        = string
}

variable "private_ip_name" {
  description = "The name of Private IP Address."
  type        = string
}

variable "private_ip_first_address" {
  description = "First IP address for Private IP Address Allocation with range /16."
  type        = string
}

variable "svpc_connector_name" {
  description = "The name of Serverless VPC Connector."
  type        = string
}

variable "svpc_connector_machine_type" {
  description = "Machine type of Serverless VPC Connector."
  type        = string
  default     = "f1-micro"
}

variable "svpc_connector_max_instances" {
  description = "Max number of Serverless VPC Connector Instances."
  type        = number
  default     = 3
}

variable "svpc_connector_min_instances" {
  description = "Min number of Serverless VPC Connector Instances."
  type        = number
  default     = 2
}

variable "svpc_connector_ip_range" {
  description = "Reserved IP range of Serverless VPC Connector Instances."
  type        = string
}
