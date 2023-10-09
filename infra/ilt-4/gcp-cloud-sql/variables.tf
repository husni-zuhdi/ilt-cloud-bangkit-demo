# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The project ID to host the database in."
  type        = string
}

variable "region" {
  description = "The region to host the database in."
  type        = string
}

variable "ilt_name" {
  description = "Name of the ILT session."
  type        = string
}

variable "vpc_network_name" {
  description = "The VPC network to host the database in."
  type        = string
}

# Note, after a name db instance is used, it cannot be reused for up to one week.
variable "name_prefix" {
  description = "The name prefix for the database instance. Will be appended with a random string. Use lowercase letters, numbers, and hyphens. Start with a letter."
  type        = string
}

variable "master_user_name" {
  description = "The username part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_name so you don't check it into source control."
  type        = string
}

variable "master_user_password" {
  description = "The password part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_password so you don't check it into source control."
  type        = string
}

variable "db_name" {
  description = "Name for the db"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "postgres_version" {
  description = "The engine version of the database, e.g. `POSTGRES_12`. See https://cloud.google.com/sql/docs/db-versions for supported versions."
  type        = string
  default     = "POSTGRES_12"
}

variable "machine_type" {
  description = "The machine type to use, see https://cloud.google.com/sql/pricing for more details"
  type        = string
  default     = "db-f1-micro"
}

variable "name_override" {
  description = "You may optionally override the name_prefix + random string by specifying an override"
  type        = string
  default     = null
}
