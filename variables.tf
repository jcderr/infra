variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "powerdns_api_key" {
  description = "PowerDNS API key"
  type        = string
  sensitive   = true
}

variable "powerdns_server_url" {
  description = "PowerDNS server URL"
  type        = string
  default     = "http://141.144.202.177"
}

variable "default_nameservers" {
  description = "Default nameservers for DNS zones"
  type        = list(string)
  default     = ["ns1.derrhost.com.", "ns2.derrhost.com."]
}

variable "default_ttl" {
  description = "Default TTL for DNS records"
  type        = number
  default     = 300
}

variable "home_ip_address" {
  description = "Home/office IP address for administrative access"
  type        = string
  sensitive   = true
}