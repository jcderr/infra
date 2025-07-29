output "zone_name" {
  description = "The name of the created DNS zone"
  value       = powerdns_zone.zone.name
}

output "zone_id" {
  description = "The ID of the created DNS zone"
  value       = powerdns_zone.zone.id
}