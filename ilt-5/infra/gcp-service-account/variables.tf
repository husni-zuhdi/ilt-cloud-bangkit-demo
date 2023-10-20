/**
 * Copyright 2019 Google LLC
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
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "project_roles" {
  type        = string
  description = "List of roles will be bind to service account separated by ','. e.g 'editor,storage.objectViewer'"
  default     = "editor,storage.objectViewer"
}

variable "prefix" {
  type        = string
  description = "Prefix applied to service account names."
  default     = ""
}

variable "sa_name" {
  type        = string
  description = "Name of the service account. Separated by '-'"
}

variable "sa_display_name" {
  type        = string
  description = "Display name of the service account."
}
