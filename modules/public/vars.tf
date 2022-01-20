variable "name" {
  description = "Route53 Zone name"
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
