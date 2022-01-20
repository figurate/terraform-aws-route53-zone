variable "name" {
  description = "Route53 Zone name"
}

variable "vpc_name" {
  description = "Name of VPC to associate with a private zone (set as null for a public zone)"
  default     = null
}

variable "records" {
  description = "A list of records (FQDN, record type, target addresses)"
  type        = list(tuple([string, string, list(string)]))
  default     = []
}

variable "aliases" {
  description = "A list of aliases (FQDN, target dns, target zone)"
  type        = list(tuple([string, string, string]))
  default     = []
}
