terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    powerdns = {
      source  = "pan-net/powerdns"
      version = "1.5.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

provider "powerdns" {
  api_key    = var.powerdns_api_key
  server_url = var.powerdns_server_url
}

# Include environment-specific configurations
module "firewall_all" {
  source = "./modules/firewall"
  
  firewall_name = "all-servers-rules"
  droplet_ids   = []
  
  inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "1-65535"
      source_addresses = [var.home_ip_address]
    },
    {
      protocol         = "icmp"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
  
  outbound_rules = [
    {
      protocol              = "tcp"
      port_range            = "53"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "53"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

module "firewall_web" {
  source = "./modules/firewall"
  
  firewall_name = "webserver-rules"
  droplet_ids   = []
  
  inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "2087"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
  
  outbound_rules = [
    {
      protocol              = "tcp"
      port_range            = "25"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

module "firewall_ssh" {
  source = "./modules/firewall"
  
  firewall_name = "ssh-rules"
  droplet_ids   = []
  
  inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

module "firewall_dns" {
  source = "./modules/firewall"
  
  firewall_name = "dns-server-rules"
  droplet_ids   = []
  
  inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "2087"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "53"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "953"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "udp"
      port_range       = "53"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

# DNS Domain configurations
module "derr_io" {
  source = "./modules/dns-zone"
  
  domain_name = "derr.io"
  apex_ip     = "129.146.58.44"
  
  additional_a_records = {
    "vpn"         = "83.84.178.179"
    "wiki"        = "141.144.202.177"
    "misty-river" = "141.144.202.177"
    "tracker"     = "129.146.58.44"
    "maggipicayune" = "129.146.58.44"
  }
  
  additional_cname_records = {
    "mail" = "ghs.googlehosted.com."
    "sig1._domainkey" = "sig1.dkim.derr.io.at.icloudmailadmin.com."
  }
  
  mx_records = [
    "10 mx01.mail.icloud.com.",
    "10 mx02.mail.icloud.com.",
  ]
  
  txt_records = [
    "\"apple-domain=viO7SYZOi5TVDOX5\"",
    "\"v=spf1 include:icloud.com ~all\"",
  ]
}

module "undeadsleds" {
  source = "./modules/dns-zone"
  
  domain_name = "undeadsleds.com"
  apex_ip     = "129.146.166.126"
}

module "karenderr" {
  source = "./modules/dns-zone"
  
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
  source = "./modules/dns-zone"
  
  domain_name = "xtrasketchy.com"
  apex_ip     = "129.146.166.126"
}

module "maggipicayune" {
  source = "./modules/dns-zone"
  
  domain_name = "maggipicayune.net"
  apex_ip     = "129.146.58.44"
}
