variable "project_id" {
  description = "The project ID of Firewall rule."
  type        = string
}

variable "name" {
  description = "The name of Firewall rule"
  type        = string
}

variable "network_self_link" {
  description = "The VPC network Self Link URI of Firewall rule"
  type        = string
}

variable "protocol" {
  description = "Protocol of Firewall rule"
  type        = string
}

variable "ports" {
  description = "List of allowed ports in a Firewall rule"
  type        = list(string)
}

variable "source_ranges" {
  description = "List of allowed source ranges of Firewall rule"
  type        = list(any)
  default     = []
}

variable "target_tags" {
  description = "List of allowed target tags of Firewall rule"
  type        = list(any)
  default     = []
}

