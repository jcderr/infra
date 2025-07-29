output "firewall_id" {
  description = "The ID of the created firewall"
  value       = digitalocean_firewall.firewall.id
}

output "firewall_name" {
  description = "The name of the created firewall"
  value       = digitalocean_firewall.firewall.name
}