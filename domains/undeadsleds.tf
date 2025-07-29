module "undeadsleds" {
  source = "../modules/dns-zone"
  
  domain_name = "undeadsleds.com"
  apex_ip     = "129.146.166.126"
}

module "karenderr" {
  source = "../modules/dns-zone"
  
  domain_name = "karenderr.com"
  apex_ip     = "129.146.166.126"
  
  mx_records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
  ]
}

module "xtrasketchy" {
  source = "../modules/dns-zone"
  
  domain_name = "xtrasketchy.com"
  apex_ip     = "129.146.166.126"
}