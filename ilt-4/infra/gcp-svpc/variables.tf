variable "project" {
  description = "The project ID to where VPC will created."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "private_ip_first_address" {
  description = "First IP address for Private IP Address Allocation with range /16."
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
