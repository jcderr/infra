terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_firewall" "firewall" {
  name        = var.firewall_name
  droplet_ids = var.droplet_ids

  dynamic "inbound_rule" {
    for_each = var.inbound_rules
    content {
      protocol           = inbound_rule.value.protocol
      port_range         = inbound_rule.value.port_range
      source_addresses   = inbound_rule.value.source_addresses
      source_droplet_ids = inbound_rule.value.source_droplet_ids
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_rules
    content {
      protocol                = outbound_rule.value.protocol
      port_range              = outbound_rule.value.port_range
      destination_addresses   = outbound_rule.value.destination_addresses
      destination_droplet_ids = outbound_rule.value.destination_droplet_ids
    }
  }
}