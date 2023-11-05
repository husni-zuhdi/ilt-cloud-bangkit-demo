variable "project_id" {
  description = "The project ID to where Google Compute Engine will be created."
  type        = string
}

variable "name" {
  description = "The name of Google Compute Engine"
  type        = string
}

variable "zone" {
  description = "Zone where Google Compute Engine will be created"
  type        = string
}

variable "machine_type" {
  description = "Machine type of Google Compute Engine"
  type        = string
  default     = "f1-micro"
}

variable "tags" {
  description = "Tags of Google Compute Engine"
  type        = list(string)
  default     = [""]
}

variable "image_project" {
  description = "Image Project of Google Compute Engine root disk"
  type        = string
  default     = "cos-cloud"
}

variable "image_family" {
  description = "Image Family of Google Compute Engine root disk"
  type        = string
  default     = "cos-stable"
}

variable "image_name" {
  description = "Image Name of Google Compute Engine root disk"
  type        = string
  default     = "cos-stable-109-17800-0-51"
}

variable "vpc_self_link" {
  description = "Self Link URI of VPC where Google Compute Engine will be deployed"
  type        = string
}

variable "subnet_self_link" {
  description = "Self Link URI of Subnet where Google Compute Engine will be deployed"
  type        = string
}

variable "ip_address" {
  description = "Static External IP Address of Google Compute Engine"
  type        = string
}

variable "service_image_uri" {
  description = "URI of container image that will be deployed in Google Compute Engine"
  type        = string
}

variable "service_name" {
  description = "Name of service that will be deployed in Google Compute Engine"
  type        = string
}

variable "sa_email" {
  description = "Email of custom service account"
  type        = string
}

