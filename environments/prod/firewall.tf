module "firewall_all" {
  source = "../../modules/firewall"
  
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
  source = "../../modules/firewall"
  
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
  source = "../../modules/firewall"
  
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
  source = "../../modules/firewall"
  
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