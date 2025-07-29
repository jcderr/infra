variable "firewall_name" {
  description = "Name of the firewall"
  type        = string
}

variable "droplet_ids" {
  description = "List of droplet IDs to apply firewall to"
  type        = list(number)
  default     = []
}

variable "inbound_rules" {
  description = "List of inbound firewall rules"
  type = list(object({
    protocol           = string
    port_range         = optional(string)
    source_addresses   = optional(list(string))
    source_droplet_ids = optional(list(number))
  }))
  default = []
}

variable "outbound_rules" {
  description = "List of outbound firewall rules"
  type = list(object({
    protocol                = string
    port_range              = optional(string)
    destination_addresses   = optional(list(string))
    destination_droplet_ids = optional(list(number))
  }))
  default = []
}