variable "project" {
  description = "The project ID to where VPC will created."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "subnet_ip_range" {
  description = "IP range of a single subnet inside VPC."
  type        = string
}

variable "subnet_region" {
  description = "Region of a subnet inside VPC."
  type        = string
}
