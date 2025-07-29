# Infrastructure as Code - Modular Terraform

This repository contains the modularized Terraform configuration for managing DNS zones and firewall rules.

## Structure

```
├── main.tf                    # Root module with providers and configurations
├── variables.tf               # Global variable definitions
├── terraform.tfvars.example  # Example variable values
├── terraform.tfvars          # Actual values (gitignored)
├── modules/
│   ├── dns-zone/             # Reusable DNS zone module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── firewall/             # Firewall rules module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   └── prod/                 # Environment-specific configs (legacy)
└── domains/                  # Domain-specific overrides (legacy)
```

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Fill in your actual API keys and tokens
3. Run `terraform init` to initialize modules
4. Run `terraform plan` to review changes
5. Run `terraform apply` to apply changes

## Adding New Domains

To add a new domain, simply add a new module block in `main.tf`:

```hcl
module "newdomain" {
  source = "./modules/dns-zone"
  
  domain_name = "newdomain.com"
  apex_ip     = "1.2.3.4"
  
  # Optional configurations
  additional_a_records = {
    "subdomain" = "1.2.3.5"
  }
  
  mx_records = [
    "10 mail.example.com.",
  ]
}
```

## Security

- All sensitive credentials are stored in `terraform.tfvars` (gitignored)
- API keys and tokens should never be committed to version control
- Use environment variables for CI/CD pipelines

## Modules

### DNS Zone Module
Creates a PowerDNS zone with:
- Apex A record
- WWW CNAME record
- Optional MX, TXT, and additional A/CNAME records

### Firewall Module  
Creates DigitalOcean firewall rules with:
- Configurable inbound/outbound rules
- Support for protocol, port ranges, and source/destination addresses