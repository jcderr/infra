terraform {
  required_providers {
    powerdns = {
      source  = "pan-net/powerdns"
      version = "1.5.0"
    }
  }
}

resource "powerdns_zone" "zone" {
  name        = "${var.domain_name}."
  kind        = "Native"
  nameservers = var.nameservers
}

resource "powerdns_record" "apex" {
  zone = powerdns_zone.zone.name
  name = "${var.domain_name}."
  type = "A"
  ttl  = var.default_ttl
  records = [
    var.apex_ip
  ]
}

resource "powerdns_record" "www" {
  zone = powerdns_zone.zone.name
  name = "www.${var.domain_name}."
  type = "CNAME"
  ttl  = var.default_ttl
  records = [
    var.www_cname_target != null ? var.www_cname_target : powerdns_zone.zone.name
  ]
}

resource "powerdns_record" "mx" {
  count = length(var.mx_records) > 0 ? 1 : 0
  
  zone = powerdns_zone.zone.name
  name = "${var.domain_name}."
  type = "MX"
  ttl  = var.default_ttl
  records = var.mx_records
}

resource "powerdns_record" "txt" {
  count = length(var.txt_records) > 0 ? 1 : 0
  
  zone = powerdns_zone.zone.name
  name = "${var.domain_name}."
  type = "TXT"
  ttl  = var.default_ttl
  records = var.txt_records
}

resource "powerdns_record" "additional_a" {
  for_each = var.additional_a_records
  
  zone = powerdns_zone.zone.name
  name = "${each.key}.${var.domain_name}."
  type = "A"
  ttl  = var.default_ttl
  records = [each.value]
}

resource "powerdns_record" "additional_cname" {
  for_each = var.additional_cname_records
  
  zone = powerdns_zone.zone.name
  name = "${each.key}.${var.domain_name}."
  type = "CNAME"
  ttl  = var.default_ttl
  records = [each.value]
}