variable "project" {
  description = "The project ID to deploy the Cloud Run container."
  type        = string
}

variable "region" {
  description = "The region to deploy the Cloud run container."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "image" {
  description = "URI of container image that you want to deploy."
  type        = string
}

variable "db_user" {
  description = "Environment Variable of DB_USER."
  type        = string
}

variable "db_password" {
  description = "Environment Variable of DB_PASSWORD."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Environment Variable of DB_PORT."
  type        = string
  default     = "5432"
}

variable "max_scale" {
  description = "Max number of Cloud Run containers."
  type        = number
  default     = 1
}

variable "min_scale" {
  description = "Min number of Cloud Run containers."
  type        = number
  default     = 1
}

variable "svpc_access" {
  description = "Serverless VPC Access connector name."
  type        = string
}
