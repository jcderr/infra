#!/bin/bash

# Script to migrate Terraform state from flat structure to modular structure
# This preserves existing resources and avoids destroy/create operations

echo "Starting Terraform state migration..."

# Move firewall resources to modules
echo "Moving firewall resources..."
terraform state mv digitalocean_firewall.all module.firewall_all.digitalocean_firewall.firewall
terraform state mv digitalocean_firewall.web module.firewall_web.digitalocean_firewall.firewall
terraform state mv digitalocean_firewall.ssh module.firewall_ssh.digitalocean_firewall.firewall
terraform state mv digitalocean_firewall.dns module.firewall_dns.digitalocean_firewall.firewall

# Move derr.io DNS resources
echo "Moving derr.io DNS resources..."
terraform state mv powerdns_zone.derr-io module.derr_io.powerdns_zone.zone
terraform state mv powerdns_record.derr-io-apex module.derr_io.powerdns_record.apex
terraform state mv powerdns_record.derr-io-www module.derr_io.powerdns_record.www
terraform state mv powerdns_record.derr-io-mx 'module.derr_io.powerdns_record.mx[0]'
terraform state mv powerdns_record.derr-io-txt-icloud-spf 'module.derr_io.powerdns_record.txt[0]'
terraform state mv powerdns_record.derr-io-mail 'module.derr_io.powerdns_record.additional_cname["mail"]'
terraform state mv powerdns_record.derr-io-cname-icloud-dkim 'module.derr_io.powerdns_record.additional_cname["sig1._domainkey"]'
terraform state mv powerdns_record.vpn-derr-io 'module.derr_io.powerdns_record.additional_a["vpn"]'
terraform state mv powerdns_record.wiki-derr-io 'module.derr_io.powerdns_record.additional_a["wiki"]'
terraform state mv powerdns_record.misty-river-derr-io 'module.derr_io.powerdns_record.additional_a["misty-river"]'
terraform state mv powerdns_record.tracker-derr-io 'module.derr_io.powerdns_record.additional_a["tracker"]'
terraform state mv powerdns_record.maggipicayune-derr-io 'module.derr_io.powerdns_record.additional_a["maggipicayune"]'

# Move karenderr.com DNS resources
echo "Moving karenderr.com DNS resources..."
terraform state mv powerdns_zone.karenderr module.karenderr.powerdns_zone.zone
terraform state mv powerdns_record.kd-apex module.karenderr.powerdns_record.apex
terraform state mv powerdns_record.kd-www module.karenderr.powerdns_record.www
terraform state mv powerdns_record.kd-mx 'module.karenderr.powerdns_record.mx[0]'

# Move undeadsleds.com DNS resources
echo "Moving undeadsleds.com DNS resources..."
terraform state mv powerdns_zone.undeadsleds module.undeadsleds.powerdns_zone.zone
terraform state mv powerdns_record.uds-apex module.undeadsleds.powerdns_record.apex
terraform state mv powerdns_record.uds-www module.undeadsleds.powerdns_record.www

# Move xtrasketchy.com DNS resources
echo "Moving xtrasketchy.com DNS resources..."
terraform state mv powerdns_zone.xtrasketchy module.xtrasketchy.powerdns_zone.zone
terraform state mv powerdns_record.xtrasketchy-com-apex module.xtrasketchy.powerdns_record.apex
terraform state mv powerdns_record.xtrasketchy-com-www module.xtrasketchy.powerdns_record.www

# Move maggipicayune.net DNS resources
echo "Moving maggipicayune.net DNS resources..."
terraform state mv powerdns_zone.maggipicayune module.maggipicayune.powerdns_zone.zone
terraform state mv powerdns_record.mp-apex module.maggipicayune.powerdns_record.apex
terraform state mv powerdns_record.mp-www module.maggipicayune.powerdns_record.www

echo "State migration complete!"
echo "Run 'terraform plan' to verify no changes are needed."