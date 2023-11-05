variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "region" {
  description = "Region of Google Compute Engine."
  type        = string
}

variable "machine_type" {
  description = "Machine Type of Google Compute Engine."
  type        = string
}
