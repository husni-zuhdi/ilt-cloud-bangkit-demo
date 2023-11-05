variable "project" {
  description = "The project ID to where VPC will created."
  type        = string
}

variable "vpc_name" {
  description = "The name of VPC."
  type        = string
}

variable "subnet_name" {
  description = "The name of single ubnet inside VPC."
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
