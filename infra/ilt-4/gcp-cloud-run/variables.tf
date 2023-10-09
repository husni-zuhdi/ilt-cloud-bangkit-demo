/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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

variable "name_override" {
  description = "Overiding Cloud Run name."
  type        = string
  default     = null
}
