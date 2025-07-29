variable "domain_name" {
  description = "Domain name for the DNS zone"
  type        = string
}

variable "nameservers" {
  description = "Nameservers for the DNS zone"
  type        = list(string)
  default     = ["ns1.derrhost.com.", "ns2.derrhost.com."]
}

variable "apex_ip" {
  description = "IP address for the apex domain"
  type        = string
}

variable "www_cname_target" {
  description = "Target for www CNAME record (defaults to apex)"
  type        = string
  default     = null
}

variable "mx_records" {
  description = "MX records for the domain"
  type        = list(string)
  default     = []
}

variable "txt_records" {
  description = "TXT records for the domain"
  type        = list(string)
  default     = []
}

variable "additional_a_records" {
  description = "Additional A records as map of subdomain to IP"
  type        = map(string)
  default     = {}
}

variable "additional_cname_records" {
  description = "Additional CNAME records as map of subdomain to target"
  type        = map(string)
  default     = {}
}

variable "default_ttl" {
  description = "Default TTL for DNS records"
  type        = number
  default     = 300
}